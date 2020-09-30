"""MQ-stalker

Usage:
stalk.py
stalk.py <specificQueueName>

Options:
-h --help     Show this screen.
--version     Show version.

"""
import sys
import time
import posix_ipc
import multiprocessing as mp
from docopt import docopt
from pyfiglet import Figlet
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler

def printFiglet():
    f = Figlet(font='isometric3')
    print(f.renderText('MQ-STALKER'))

# Queue should converted to a two-way msg bus that
# will help us do graceful worker termination and cleanup
def interceptCommunications(queueName, queue=None):
    mq = posix_ipc.MessageQueue(f"/{queueName}", read=True, write=False)
    while True:
        msg,_ = mq.receive()
        msg = msg.decode()
        if queue == None:
            print(msg)
        else:
            queue.put(msg)

if __name__ == "__main__":
    printFiglet()
    arguments = docopt(__doc__, version='mq-stalker 0.1.0')
    specificQueueName, *_ = arguments.values()

    mp.set_start_method('spawn')
    q = mp.Queue()
    childProcessList = []

    def on_creation_multi(event):
        print(f"[NEW MSG QUEUE!] {event.src_path} has been created!")
        queueName = event.src_path.split('/')[3]
        p = mp.Process(target=interceptCommunications, args=(queueName, q))
        p.start()
    
    def on_creation_single(event):
        if event.src_path == f"/dev/mqueue/{specificQueueName}":
            print(f"[NEW MSG QUEUE!] {event.src_path} has been created!")
            interceptCommunications(specificQueueName)
    
    queueRootPath = "/dev/mqueue"
    event_handler = PatternMatchingEventHandler()

    if specificQueueName == None:
        print("[+] Listening for ANY queue creation...")
        event_handler.on_created = on_creation_multi
    else:
        print("[+] Listening for our specific queue..")
        event_handler.on_created = on_creation_single
    
    observer = Observer()
    observer.schedule(event_handler, queueRootPath, recursive=False)
    observer.start()
    
    try:
        while True:
            print(q.get())
    except KeyboardInterrupt:
        observer.stop()
        observer.join()