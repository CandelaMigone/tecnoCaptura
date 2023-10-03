class Jugador extends FBox {
  int velocidad;
//Administrador administrador; 
  Jugador(float _ancho, float _alto) {
    super (_ancho, _alto);
   // administrador = new Administrador(mundo);
  }
  
  void inicializar () {
    setName ("jugador"); // Asignacion de nombre
    setPosition (width / 2, height - 117/2); // Asignacion de posición
    setGrabbable (true); // ¿Se puede agarrar? *va false
    setRotatable (false); // ¿Es estático?
   // administrador = administrador_;
    
  }
  
  void actualizar () {
        //setPosition (mouseX, height - 117/2); // se reemplaza por cadena
  }
}
