class Verdura extends FCircle {

  float anguloVel = 40;
  float diamVerdura = 50;
  float velocidad = 500;
  float angulo;
  float vyVerdura;
  float vxVerdura;
  String tipo;
  float posX;


  Verdura(String _tipo) { //, String _tipo
    super (50);
    tipo = _tipo;

    angulo = radians( -90 );
  }

  void inicializar() {
    if (tipo.equals("verdura1")) {
      setName ("verdura1"); // Asignacion de nombre
      posX = -5;
      setPosition (posX, random (50, 100)); // Asignacion de posición
      setGrabbable (false); // ¿Se puede agarrar? *va false
      setStatic (false); // ¿Es estático?
      setRestitution (1);
      setDamping (-1);

      float anguloVerdura = angulo + radians(90); 
      vxVerdura = velocidad * cos(anguloVerdura);
      vyVerdura = velocidad * sin(anguloVerdura);
      verdura1.setVelocity(vxVerdura, vyVerdura); // Usar las componentes giradas
    } else if (tipo.equals("verdura2")) {      
      setName ("verdura2"); // Asignacion de nombre
      posX = width+5;
      setPosition (posX, random (50, 100)); // Asignacion de posición
      setGrabbable (false); // ¿Se puede agarrar? *va false
      setStatic (false); // ¿Es estático?
      setRestitution (1);
      setDamping (-1);
      
      float anguloVerdura = angulo - radians(90); 
      vxVerdura = velocidad * cos(anguloVerdura);
      vyVerdura = velocidad * sin(anguloVerdura);
      verdura2.setVelocity(vxVerdura, vyVerdura); // Usar las componentes giradas
    }
  }
}
