# InterHacktive 2023
<div align="center">
 <kbd><img src="https://github.com/statuscode-418/EenTrack/assets/124903208/5e584551-4c30-43e5-b28c-335b3e078211" width="100" height="100"/></kbd>
</div>
<h1 align="center"> EenTrack </h1>
<h1 align="center"> A hassle free Event Entry Tracker </h1>
<h3 align="center"> <a align="center" href="##">Watch Demo Video</a> </h3>
<br>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#tech-stacks-used">Tech Stacks used</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>


<h1 id="about-the-project">🤩 About The Project :</h1>

[Demo Trial.webm](https://github.com/statuscode-418/EenTrack/assets/124903208/51e30780-60f8-4dc4-be12-b16f68f831e1)

# 💭 Inspiration :
- Being a college student we are enrolled in a lot of communities. We do a lot of community meetings as well. One problem that comes up again and again is regarding attendance. We need to take the attendance of attendees to give it to college, to compensate for their college attendance, and it also helps to keep track of activeness of the members.
  
Some existing solutions are:

-  <H3>Physical Ledger</H3> 
&nbsp;&nbsp; The physical ledger book is simple, you just take a ledger book and makes the attendee fill in their details one by one.

Pros:
1. Easy to set up initially
2. No previous knowledge of attendees needed.

Cons: 
1. Takes too much time to resister each attendee one by one.
2. Much more hasel to entry that data in Excel sheet.
 


-  <H3>Custom attendace systems for large meetings</H3>
&nbsp;&nbsp; Some large event uses QR attendance system to keep track of attendance.

Pros:
1. Fast attendance
2. Digital data so easy to manipulate

Cons:
1. You must have a attendee list beforehand, mostly taken through Google forms
2. A big hasel for small community meetings

- To solve this problem , we came up with a solution using **Cross Platform Framework Flutter**. 
Getting inspiration from this two systems, and analysing it's pros and cons, we made our app EenTrack.



# 💡 What problem does the project solve?
- The project aims to solve the problem of **Attendance Tracking** in small and medium community meetings.
- Creating a meeting is as easy as pressing a button and doesnot need an attendee list beforehand.
- By scanning the generated QR registration of candidates becomes easy and less time consuming.
- The export feature uploads all details in Excel sheet thus saving us from the manual labour of data entry.


<h1 id="usage">📌 Usage :</h1>

### Register phase:
1. Users will register using email and password.
2. Data of students like name, roll, sem, phone, GitHub profile (optional), LinkedIn profile (optional)
3. Once logged in, either you can join a meeting or create a meeting.

### Create meeting:
1. Once logged in, go to create meetings tab
2. There you will see your past meetings if you have any
3. Tap on create meeting
4. You will be navigated to a screen where you'll see a QR code, using which attendee will mark their attendance.
5. Below the QR code you'll get the list of attendees who scanned the QR
6. Once all the attendance is taken, press the export button to export the details of attendees in Excel sheet

### Join a meeting:
1. Click the scan QR button
2. Scan the QR code of a meeting
3. Your attendance is recorded on that meeting

# 💀 Challenges we ran into:
  - Creating the best UI which is logical as well as simple and easy to use was a challenge
  - To convert the design file into responsive flutter code was a big challenge
  - Managing auth state was a big issue that we solved using block
  - Figuring out the best database model to store the user data was a big challenge
  - Managing a team of developer to push their code in a single repo and work together was a big challenge in itself

 
# 🔮 What's Next For Our Project:
- Making the attendace tracking system in a more organised way by enabling the two QR based Attendance Tracker during entry and exit
- Identity Validation of the attendee who is joining the meeting by maintaining a proper database
- Large Screen Optimization and minor bug fixes
  

<h1 id="tech-stacks-used">👨‍💻 Tech Stacks used :</h1>
- <img src = "https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg" style="margin-top: 40px" height=30px width=30px > **Dart** : For writing the codebase of the app.
- <img src = "https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" style="margin-top: 40px" height=30px width=30px >**Flutter** :  It gave us a beautiful default setup, and the flexibility to customise as per our need. It also enabled us to ship our app in Android, iOS, and potentially on web from a single codebase.
- <img src = "https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg" style="margin-top: 40px" height=30px width=30px >**Firebase Auth** : To make the backend, we used One of the Google cloud services product, Firebase. It enabled us to easily and securely handle user authentication using firebase auth.
- <img src = "https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg" style="margin-top: 40px" height=30px width=30px >**Cloud Firestore** : Managing user data using firestore.
- <img src = "https://www.vectorlogo.zone/logos/firebase/firebase-icon.svg" style="margin-top: 40px" height=30px width=30px >**Firebase Storage** : For storing profile pics using storage also due to is awesome support for flutter enabled us to easily use it in our project.


# Special Quirks :
- Supports Material U dynamic coloring on android 12+
- Random Profile Avatar on registering based on name


<h1 id="installation">Installation :</h1>

To use this app:
- Download the apk file from <a href="#">here</a>
- Install the apk
- open the app and Enjoy 😉!!


# Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "improvement".
Don't forget to star this project!! 

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/Feature1`)
3. Commit your Changes (`git commit -m 'Add Feature 1'`)
4. Push to the Branch (`git push origin feature/Feature1`)
5. Open a Pull Request

# Contributors

<h3 align="center">Made with ❤️ by Status_code-418!</h3>
 <p align ="right"><a href="#top">🔼 Back to top</a></p>
 </div>
