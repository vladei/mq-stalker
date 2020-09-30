# mq-stalker
Sometimes developers use weak permissions during their POSIX message queue creation. Mq-stalker makes intercepting 
messages from those queues easier. Make sure to run mq-stalker *before* you create the message queues, in 
order to retrieve as many messages as you can! 


```
      ___                         ___                       ___     
     /__/\          ___          /  /\          ___        /  /\    
    |  |::\        /  /\        /  /:/_        /  /\      /  /::\   
    |  |:|:\      /  /::\      /  /:/ /\      /  /:/     /  /:/\:\  
  __|__|:|\:\    /  /:/\:\    /  /:/ /::\    /  /:/     /  /:/~/::\ 
 /__/::::| \:\  /  /:/~/::\  /__/:/ /:/\:\  /  /::\    /__/:/ /:/\:\
 \  \:\~~\__\/ /__/:/ /:/\:\ \  \:\/:/~/:/ /__/:/\:\   \  \:\/:/__\/
  \  \:\       \  \:\/:/__\/  \  \::/ /:/  \__\/  \:\   \  \::/     
   \  \:\       \  \::/        \__\/ /:/        \  \:\   \  \:\     
    \  \:\       \__\/           /__/:/          \__\/    \  \:\    
     \__\/                       \__\/                     \__\/    
                    ___           ___           ___     
                   /__/|         /  /\         /  /\    
                  |  |:|        /  /:/_       /  /::\   
  ___     ___     |  |:|       /  /:/ /\     /  /:/\:\  
 /__/\   /  /\  __|  |:|      /  /:/ /:/_   /  /:/~/:/  
 \  \:\ /  /:/ /__/\_|:|____ /__/:/ /:/ /\ /__/:/ /:/___
  \  \:\  /:/  \  \:\/:::::/ \  \:\/:/ /:/ \  \:\/:::::/
   \  \:\/:/    \  \::/~~~~   \  \::/ /:/   \  \::/~~~~ 
    \  \::/      \  \:\        \  \:\/:/     \  \:\     
     \__\/        \  \:\        \  \::/       \  \:\    
                   \__\/         \__\/         \__\/    

Usage:
stalk.py
stalk.py <specificQueueName>

Options:
-h --help     Show this screen.
--version     Show version.
```

Happy stalking 🏴‍☠️ 🏴‍☠️ 🏴‍☠️
