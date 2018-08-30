import processing.video.*;

Capture cam;
int textsize = 10;

//setup text;
String test = "The evolution of typographic reproduction and display technologies has and continues to impact human culture. Early printing techniques developed by Johannes Gutenberg in fifteenth-century Germany using letters cast from lead provided a catalyst for increased literacy and the scientific revolution. Automated typesetting machines, such as the Linotype invented in the nineteenth century, changed the way information was produced, distributed, and consumed. In the digital era, the way we consume text has changed drastically since the proliferation of personal computers in the 1980s and the rapid growth of the Internet in the 1990s. Text from emails, websites, and instant messages fill computer screens, and while many of the typographic rules of the past apply, type on screen requires additional considerations for enhanced communication and legibility. Letters on screen are created by setting the color of pixels. The quality of the typography is constrained by the resolution of the screen. Because, historically, screens have a low resolution in comparison to paper, techniques have been developed to enhance the appearance of type on screen. The fonts on the earliest Apple Macintosh computers comprised small bitmap images created at specific sizes like 10, 12, and 24 points. Using this technology, a variation of each font was designed for each size of a particular typeface. For example, the character A in the San Francisco typeface used a different image to display the character at size 12 and 18. When the LaserWriter printer was introduced in 1985, Postscript technology defined fonts with a mathematical description of each character's outline. This allowed type on screen to scale to large sizes and still look smooth. Apple and Microsoft later developed TrueType, another outline font format. More recently, these technologies were merged into the OpenType format. In the meantime, methods to smooth text on screen were introduced. These anti-aliasing techniques use gray pixels at the edge of characters to compensate for low screen resolution. The proliferation of personal computers in the mid-1980s spawned a period of rapid typographic experimentation. Digital typefaces are software, and the old rules of metal and photo type no longer apply. The Dutch typographers known as LettError explain, \"The industrial methods of producing typography meant that all letters had to be identical… Typography is now produced with sophisticated equipment that doesn't impose such rules. The only limitations are in our expectations.\"1 LettError expanded the possibilities of typography with their typeface Beowolf (p. 131). It printed every letter differently so that each time an A is printed, for example, it will have a different shape. During this time, typographers such as Zuzana Licko and Barry Deck created innovative typefaces with the assistance of new software tools. The flexibility of software has enabled extensive font revivals and historic homages such as Adobe Garamond from Robert Slimbach and The Proteus Project from Jonathan Hoefler. Typographic nuances such as ligatures—connections between letter pairs such as fi and æ—made impractical by modern mechanized typography are flourishing again through software font tools.";
char input;
int count = 0;
PFont Times;

//setup various modes
boolean colored = true;
boolean variation = true;
boolean reversed = false;

//setup buttons
Button col = new Button("Color Mode", 580, 350);
Button size = new Button("Size Mode", 580, 400);
Button rev = new Button("Reverse Mode", 580, 450);


void setup() {
  background(200);
  size(640, 480);
  Times = loadFont("TimesNewRomanPSMT-48.vlw");
  textFont(Times);
  textAlign(CENTER);
  cam = new Capture(this, width, height);
  cam.start();
}

void draw() {
  colored = !col.clicked;
  variation = !size.clicked;
  reversed = rev.clicked;
  
  if (frameCount%10==0) {
    background(230);
    if (cam.available()) {
      cam.read();
      flip(cam);
    }

    for (int y=10; y<cam.height; y+=12) {
      for (int x=5; x+textsize<cam.width; x+=textWidth(input) + 1) {
        color c = cam.pixels[y*cam.width + x];
        if (variation) {
          float textbright = brightness(c);
          textbright = constrain(textbright, 50, 200);
          if (reversed){
          textsize = int(map(textbright, 50, 200, 10, 30));
          } else{
          textsize = int(map(textbright, 200, 50, 10, 30));
          }
        } else {
          textsize = 20;
        }
        input = test.charAt(count);
        if (count<test.length()-1) {
          count++;
        } else {
          count = 0;
        }

        textSize(textsize);
        if (colored) {
          fill(c);
        } else {
          fill(0);
        }
        text(input, x, y);
      }
    }
    count = 0;
  }
      
  col.show();
  size.show();
  rev.show();
}
