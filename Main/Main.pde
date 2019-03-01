PImage displayScreen;

ControlP5 cp5;

void setup() 
{
  size(1200, 800);

  cp5 = new ControlP5(this);

  displayScreen = loadImage("BackGround.jpg");

  Gui(); // initiate button/textfield objects

  loginView();
} 

void draw() 
{
  image(displayScreen, 0, 0);

  if (adminMode == true && viewAdminInfo == true)
  {  // Display Student info in Admin View
    text(aID, 120, 198);
    text(aName, 165, 353);
    text(aGPA, 143, 660);
  }
 /* else if (userMode == true && viewUserInfo == true)
  { // Display Student info in User View
    text(aID, 120, 198);
    text(aName, 165, 353);
    text(aGPA, 143, 660);
  }*/
}

void keyPressed()
{
  switch(key)
  {
  case TAB:
    Textfield userBox = (Textfield) cp5.getController("uBox");
    Textfield passBox = (Textfield) cp5.getController("pBox");

    if (userBox.isFocus() == true)
    {
      userBox.setFocus(false);
      passBox.setFocus(true);
    } else if (passBox.isFocus() == true)
    {
      userBox.setFocus(true);
      passBox.setFocus(false);
    }
    break;
  }
}
