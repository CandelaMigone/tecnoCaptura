// --------- Importamos bibliotecas --------- \\
import fisica.*; // Importamos la biblioteca de Físicas

FWorld mundo;

int PUERTO_OSC = 12345; // este es el puerto por donde se comunica con el programa de Matias :S

Receptor receptor; // declarar objeto receptor la clase que va a administrar la  entrada de los mensajes y asignacion de blobs
Administrador administrador; 

FBox piso; // Declaramos piso
Olla ollaDer, ollaIzq;  // Declaramos Ollas
Jugador jugador; // Declaramos jugador
Verdura verdura1, verdura2; // Declaramos verdura
FMouseJoint cadena; // Declaramos joint para mover al jugador
float currentTargetX;
float currentTargetY;

//boolean hayVerdura;

void setup () {
   size (1200, 600);
  Fisica.init (this);
  mundo = new FWorld (); // Inicializamos el mundo antes que cualquier otro objeto
  mundo.setEdges(color (0, 0));
  
  receptor = new Receptor();
 administrador = new Administrador(mundo);
  //hayVerdura = false;
  setupOSC(PUERTO_OSC); 
  mundo = new FWorld (); // Inicializamos el mundo
  mundo.setEdges(color (0, 0)); // Bordes o paredes transparentes

  piso = new FBox(width, 10); // Inicializamos el piso transparente
  piso.setPosition (width/2, height - 5); // Asignacion de posición
  piso.setName ("piso"); // Asignacion de nombre
  piso.setStroke(0, 0); // noStroke
  piso.setFill(0, 0); // noFill
  piso.setStatic (true); // ¿Es estático?
  piso.setGrabbable (false); // ¿Se puede agarrar?
  mundo.add (piso); // Agregamos piso al mundo

  ollaIzq = new Olla (200, 240, "ollaIzq"); // Inicializamos olla izquierda 
  ollaIzq.inicializar ();
  mundo.add (ollaIzq); // Agregamos olla izquierda al mundo

  ollaDer = new Olla (200, 240, "ollaDer"); // Inicializamos olla derecha  
  ollaDer.inicializar ();
  mundo.add (ollaDer); // Agregamos olla derecha al mundo

  jugador = new Jugador (100, 10); // Inicializamos jugador
  jugador.inicializar ();
  mundo.add (jugador); // Agregamos jugador al mundo

  cadena = new FMouseJoint (jugador, width / 2, height - 117/2); // Inicializamos la cadena
  //cadena.setFrequency (1); // delay de acercamiento - = + delay
  mundo.add (cadena); // Agregamos la cadena al mundo

  verdura1 = new Verdura ("verdura1"); // Inicializamos verdura1
  verdura1.inicializar ();
  mundo.add (verdura1); // Agregamos verdura1 al mundo

  verdura2 = new Verdura ("verdura2"); // Inicializamos verdura2
  verdura2.inicializar ();
  mundo.add (verdura2); // Agregamos verdura2 al mundo
}

void draw () {
  background (200); // Se reemplaza por escenarioImg en el estado 2

//actualizamos objetos
  ollaIzq.actualizar();
  ollaDer.actualizar();
  jugador.actualizar();
   receptor.actualizar(mensajes); //  
  //receptor.dibujarBlobs(width, height);


  // Eventos de entrada y salida de blobs
  for (Blob b : receptor.blobs) {

    if (b.entro) {
      administrador.crearPuntero(b);
      println("--> entro blob: " + b.id);
    }
    if (b.salio) {
      administrador.removerPuntero(b);
      println("<-- salio blob: " + b.id);
    }
    
  administrador.actualizarPuntero(b);
    
  } 
if (!receptor.blobs.isEmpty()) {
  Blob blob = receptor.blobs.get(0); // Sup primer blob en la lista
  
   float targetX = blob.centroidX * width;
    float targetY = blob.centroidY * height;

    // Aplica lerp para suavizar el movimiento
    float lerpAmount = 0.1; // Ajusta este valor según la velocidad de suavizado deseada
    currentTargetX = lerp(currentTargetX, targetX, lerpAmount);
    currentTargetY = lerp(currentTargetY, targetY, lerpAmount);

    cadena.setTarget(currentTargetX, height - 117/2);
}

//  cadena.setTarget (mouseX, height - 117/2); // ESTE MOUSEX VA POR TU PARTE CANDE <3

  mundo.step(); // Sucede el tiempo
  mundo.draw(); // Dibuja el mundo
}


void contactStarted (FContact colision) {
  FBody _body1 = colision.getBody1();
  FBody _body2 = colision.getBody2();

  if ((_body1.getName() == "verdura1" && _body2.getName() == "piso") || (_body2.getName() == "verdura1" && (_body1.getName() == "piso"))) {
    println (_body1.getName(), _body2.getName());
    // Sonido caida
    // Restitution 0
  }

  if ((_body1.getName() == "verdura1" && _body2.getName() == "jugador") || (_body2.getName() == "verdura1" && (_body1.getName() == "jugador"))) {
    println (_body1.getName(), _body2.getName());
    // Sonido rebote
  }

  if ((_body1.getName() == "verdura1" && _body2.getName() == "ollaDer") || (_body2.getName() == "verdura1" && (_body1.getName() == "ollaDer"))) {
    println (_body1.getName(), _body2.getName());
    println (colision.getNormalX(), colision.getNormalY(), verdura1.getVelocityY());

    if (_body1.getName() == "verdura1" && colision.getNormalY() < 0) {
      println ("punto");
      // condicional solo por arriba
      // Sonido entra
    } else if (_body2.getName() == "verdura1" && colision.getNormalY() < 0) {
      println ("punto");
      // condicional solo por arriba
      // Sonido entra
    }
  }

  if ((_body1.getName() == "verdura1" && _body2.getName() == "ollaIzq") || (_body2.getName() == "verdura1" && (_body1.getName() == "ollaIzq"))) {
    println (_body1.getName(), _body2.getName());
    println (colision.getNormalX(), colision.getNormalY(), verdura1.getVelocityY());

    if (_body1.getName() == "verdura1" && colision.getNormalY() < 0) {
      println ("perdiste");
      // condicional solo por arriba
      // Sonido perder
    } else if (_body2.getName() == "verdura1" && colision.getNormalY() < 0) {
      println ("perdiste");
      // condicional solo por arriba
      // Sonido perder
    }
  }

  if ((_body1.getName() == "verdura2" && _body2.getName() == "piso") || (_body2.getName() == "verdura2" && (_body1.getName() == "piso"))) {
    println (_body1.getName(), _body2.getName());
    // Sonido caida
    // Restitution 0

  }

  if ((_body1.getName() == "verdura2" && _body2.getName() == "jugador") || (_body2.getName() == "verdura2" && (_body1.getName() == "jugador"))) {
    println (_body1.getName(), _body2.getName());
    // Sonido rebote
  }

  if ((_body1.getName() == "verdura2" && _body2.getName() == "ollaIzq") || (_body2.getName() == "verdura2" && (_body1.getName() == "ollaIzq"))) {
    println (_body1.getName(), _body2.getName());
    println (colision.getNormalX(), colision.getNormalY(), verdura2.getVelocityY());

    if (_body1.getName() == "verdura2" && colision.getNormalY() < 0) {
      println ("punto");
      // condicional solo por arriba
      // Sonido entra
    } else if (_body2.getName() == "verdura2" && colision.getNormalY() < 0) {
      println ("punto");
      // condicional solo por arriba
      // Sonido entra
    }
  }

  if ((_body1.getName() == "verdura2" && _body2.getName() == "ollaDer") || (_body2.getName() == "verdura1" && (_body1.getName() == "ollaDer"))) {
    println (_body1.getName(), _body2.getName());
    println (colision.getNormalX(), colision.getNormalY(), verdura2.getVelocityY());

    if (_body1.getName() == "verdura2" && colision.getNormalY() < 0) {
      println ("perdiste");
      // condicional solo por arriba
      // Sonido perder
    } else if (_body2.getName() == "verdura2" && colision.getNormalY() < 0) {
      println ("perdiste");
      // condicional solo por arriba
      // Sonido perder
    }
  }
}
