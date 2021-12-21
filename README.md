# RedCloud Item Delivery System
A Item Delivery system allowing one point of contact from inworld items to send to various dropboxes
IMPORTANT NOTE: This is missing a lot of stuff, like revokable auth keys in a database, or verification of where the requests are coming from, it also probably needs to have sanitization of inputs. To be added, this is just a brief script put together for starter stuff. Don't blame me when your database gets wiped. I'll add that stuff probably later on, or you can feel free to add in a pull request!

# Instructions

You'll need the Dropbox.lsl file inworld and the urlreg.php and delivery.php files + a MySQL Database w/ the Various Database things set in the PHP Files. 

Place the object to deliver and the dropbox.lsl file in the same prim. Base64 Encode the name of Object, and that is what you will place into the example delivery script. 

Ensure your auth key is in all the files. Update the group UUID in the example delivery script. 

Should work right. 




# License

MIT License. Yeah....it's ma go to. 



# Security

Security Issues not obviously pointed out in the disclaimer at the top of this readme can be put into a issue on github, or messaged to me inworld dark.nebula in Second Life. 
It's literally just a framework, but it still should be secure eventually and work out of the box. 
