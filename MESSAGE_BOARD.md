***INSTRUCTIONS FOR DOWNLOADING AND UPLOADING PHP FILES

In order to pull from the server use the Server CoPy command: scp
The flag -r means to copy recursively.
You must use your own username because you know the password to that one.
The host is the same though. Then, a colon followed by the location of the folder you want to copy. Note that there are no spaces.
The ‘./‘ means to copy to the current directory. You can edit this to whatever folder you want.

An example of a download:

scp -r codyv@107.170.219.218:/var/www/html/Capstone ./

To upload, just reverse the order of the folders. Like this:

scp -r ./Capstone codyv@107.170.219.218:/var/www/html/Capstone

***END INSTRUCTIONS


I created a bug fixes branch. I will be fixing issues #23, #22, #16, and #15. - John 11/21

Ok I went ahead and updated our App Name to be FormCycle. I created a new branch for this and I will merge this with the master. It went ahead and refactored the code to match the renaming, but its probably better to do this now then later in the project. - Merrill 11/19

write stuff you want other people to see in here. i.e. things that would be nice to know, or something we should go check out. Or just general updates about what we have been doing so we all know whats going on. - John 11/19


