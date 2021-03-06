import controlP5.*; //<>// //<>//

String aID = "", aName = ""; 
float aGPA = 0, aC_G; 
boolean viewAdminInfo = false, viewUserInfo;
boolean isOpen = false, isOpen2 = false;
Student currentStudent;
String selectedCourse;

void Gui()
{  
  StudentManager sm = StudentManager.getInstance(this);

  font = createFont("arial", 40);
  font2 = createFont("arial", 15);
  logFont = createFont("arial", 25);
  isOpen = false;

  cp5.addTextfield("uBox") // Username field
    .setPosition(358, 245)
    .setSize(502, 63)
    .setFont(font)
    .setFocus(true)
    .hide()
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    .setCaptionLabel("")
    ;

  cp5.addTextfield("pBox") // Password field
    .setPosition(358, 360)
    .setSize(502, 63)
    .setFont(font)
    .hide()
    .setFocus(false)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    .setCaptionLabel("")
    .setPasswordMode(true)
    ;

  cp5.addTextfield("EnterStudent") // new Student textfield from Add button
    .setPosition(1012, 170)
    .setSize(170, 40)
    .setFont(font2)
    .hide()
    .setFocus(true)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    ;

  cp5.addTextfield("EditName") // edit Student textfield from Edit button
    .setPosition(1012, 325)
    .setSize(170, 40)
    .setFont(font2)
    .hide()
    .setFocus(true)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    ;  

  cp5.addTextfield("EditGrade") // edit Student textfield from Edit button
    .setPosition(1012, 400)
    .setSize(170, 40)
    .setFont(font2)
    .hide()
    .setFocus(true)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    ;    
  
  cp5.addTextfield("EditCourse") // edit Student textfield from Edit button
    .setPosition(1012, 475)
    .setSize(170, 40)
    .setFont(font2)
    .hide()
    .setFocus(true)
    .setColor(color(0)) // Color of Font
    .setColorBackground(#CECACA) // Color of textfield
    ;   
  
  cp5.addButton("Add")
    .setPosition(1025, 110)
    .setSize(144, 45)
    .setFont(font) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        if (isOpen == false)
        {
          cp5.get(Textfield.class, "EnterStudent").show();
          isOpen = true;
        } else 
        {
          cp5.get(Textfield.class, "EnterStudent").hide(); 
          isOpen = false;
        }
      }
    }
  }
  );

  cp5.addButton("Edit")
    .setPosition(1025, 255)
    .setSize(144, 45)
    .setFont(font) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        if (isOpen2 == false)
        {
          cp5.get(Textfield.class, "EditName").show();
          cp5.get(Textfield.class, "EditGrade").show();
          cp5.get(Textfield.class, "EditCourse").show();
          isOpen2 = true;
        } else 
        {
          cp5.get(Textfield.class, "EditName").hide(); 
          cp5.get(Textfield.class, "EditGrade").hide();
          cp5.get(Textfield.class, "EditCourse").hide();
          isOpen2 = false;
        }
      }
    }
  }
  );

  cp5.addButton("Delete")
    .setPosition(1015, 557)
    .setSize(160, 55)
    .setFont(font) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {
          DeleteStudent();
      }
    }
  }
  );

  cp5.addButton("LOGIN")
    .setPosition(454, 466)
    .setSize(309, 63)
    .setFont(font) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        cp5.get(Textfield.class, "uBox").submit();
        cp5.get(Textfield.class, "pBox").submit();

        checkupInfo();
      }
    }
  }
  );

  cp5.addButton("LOGOUT")
    .setSize(144, 45)
    .setFont(logFont) 
    .hide()
    .setColorBackground(#73e2f9) // Color of textfield
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASED) {

        cp5.get(Button.class, "LOGOUT").hide();
        cp5.get(ScrollableList.class, "Student").hide();
        cp5.get(Button.class, "Add").hide();
        cp5.get(Button.class, "Edit").hide();
        cp5.get(Button.class, "Delete").hide();
        cp5.get(Textfield.class, "EnterStudent").hide();
        cp5.get(Textfield.class, "EditName").hide();
        cp5.get(Textfield.class, "EditGrade").hide();
        cp5.get(Textfield.class, "EditCourse").hide();
        cp5.get(ScrollableList.class, "Course").hide();
        
        displayScreen = loadImage("BackGround.jpg");

        adminMode = false;
        userMode = false;
        viewAdminInfo = false;
        
        cp5.get(ScrollableList.class, "Student").setCaptionLabel("Student");
        cp5.get(ScrollableList.class, "Course").setCaptionLabel("Course");
        cp5.get(ScrollableList.class, "Course").clear();
        aC_G = 0;

        cp5.get(Textfield.class, "uBox").show();
        cp5.get(Textfield.class, "pBox").show();
        cp5.get(Button.class, "LOGIN").show();
      }
    }
  }
  );

  // Store student names here
  cp5.addScrollableList("Student")
    .setPosition(225, 73)
    .setSize(500, 240)
    .setFont(logFont) 
    .hide()
    .close()
    .setBarHeight(40)
    .setItemHeight(50)
    .addItems(sm.getAllStudents().getStringColumn(1))
    ;

  // Store student courses here
  cp5.addScrollableList("Course")
    .setSize(500, 240)
    .setFont(logFont) 
    .hide()
    .close()
    .setBarHeight(40)
    .setItemHeight(50)
    ;
}

public void uBox(String userInfo) 
{
  checkUser = userInfo;
}

public void pBox(String passInfo) 
{
  checkPass = passInfo;
}

public void EnterStudent(String studInfo) // Add new student
{ 
  if (studInfo.equals("") == true)
  {
    showMessageDialog(null, "Student name field is empty!", "Alert", ERROR_MESSAGE); 
  }
  else
  {
    String[] newName = { studInfo }; //<>//
    StudentManager sm = StudentManager.getInstance(this);
    Student newStud = new Student();
    newStud.setStudentName(studInfo);
    HashMap<String, Integer> hm = new  HashMap<String, Integer>();
    hm.put("CS1111",0);
    hm.put("CS2222",0);
    hm.put("CS3333",0);
    hm.put("CS4444",0);
    newStud.setCurrentCourses(hm);
    sm.addStudent(newStud);
    cp5.get(ScrollableList.class, "Student").addItems(newName);
  }
}

public void EditName(String eName) // Edit Student's name function
{
  StudentManager sm = StudentManager.getInstance(this);
  currentStudent.setStudentName(eName);
  sm.editStudent(currentStudent);
  aName = eName;
  cp5.get(ScrollableList.class, "Student").setCaptionLabel(eName);
  cp5.get(ScrollableList.class, "Student").clear();
  cp5.get(ScrollableList.class, "Student").addItems(sm.getAllStudents().getStringColumn(1));
}

public void EditCourse(String eCourse) // Edit Student's course name function
{
  StudentManager sm = StudentManager.getInstance(this);
  Integer grade = currentStudent.getCurrentCourses().get(selectedCourse);
  currentStudent.getCurrentCourses().remove(selectedCourse);
  currentStudent.getCurrentCourses().put(eCourse, grade);
  sm.editStudent(currentStudent);
  cp5.get(ScrollableList.class, "Course").setCaptionLabel(eCourse);
  cp5.get(ScrollableList.class, "Course").clear();
  for ( String course : currentStudent.getCurrentCourses().keySet() ) {
    cp5.get(ScrollableList.class, "Course").addItem(course,course);
  }
}

public void EditGrade(String eGrade) // Edit Student's grade function
{
  StudentManager sm = StudentManager.getInstance(this);
  HashMap hm = currentStudent.getCurrentCourses();
  hm.put(selectedCourse, Integer.parseInt(eGrade));
  currentStudent.setCurrentCourses(hm);
  sm.editStudent(currentStudent);
  cp5.get(ScrollableList.class, "Course");
  aC_G = Integer.parseInt(eGrade);
  aGPA = currentStudent.getCurrentGPA();
}

void DeleteStudent() // Delete Student function
{ //<>//
  StudentManager sm = StudentManager.getInstance(this);
  sm.deleteStudent(aID);
  viewAdminInfo = false;
  cp5.get(ScrollableList.class, "Student").removeItem(aName);
  cp5.get(ScrollableList.class, "Student").setCaptionLabel("Student");
  cp5.get(ScrollableList.class, "Course").setCaptionLabel("Course");
}

void Student(int studentN) 
{
  cp5.get(ScrollableList.class, "Course").clear();
  cp5.get(ScrollableList.class, "Course").setCaptionLabel("Course");
  StudentManager sm = StudentManager.getInstance(this);
  currentStudent = sm.getStudentByIndex(studentN); 
  aID = currentStudent.getId();
  aName = currentStudent.getStudentName();
  aGPA = currentStudent.getCurrentGPA(); 
  aC_G = 0; // Reset Counter
  cp5.get(ScrollableList.class, "Course").clear();
  for ( String course : currentStudent.getCurrentCourses().keySet() ) {
    cp5.get(ScrollableList.class, "Course").addItem(course,course);
  }

  viewAdminInfo = true;
}

void Course(int courseN) 
{ 
  selectedCourse = cp5.get(ScrollableList.class, "Course").getItem(courseN).get("value").toString();
  aC_G = currentStudent.getCurrentCourses().get(selectedCourse);
}

void userInfo(String ID)
{
  String passRef = ID;

  StudentManager sm = StudentManager.getInstance(this);

  Student s = sm.getStudent(ID); 

  aID = s.getId();
  aName = s.getStudentName();

  aGPA = s.getCurrentGPA(); 

  viewUserInfo = true;

  userCourse(passRef);
}

void userCourse(String ID)
{    
  StudentManager sm = StudentManager.getInstance(this);

  Student s = sm.getStudent(ID); 
  cp5.get(ScrollableList.class, "Course").clear();
  for ( String course : s.getCurrentCourses().keySet() ) {
    cp5.get(ScrollableList.class, "Course").addItem(course,course);
  }
}
