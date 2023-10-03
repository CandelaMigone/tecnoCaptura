class Olla extends FBox {
  String lado;
  
  Olla (float _w, float _h, String _lado) {
    super (_w, _h);
    lado = _lado;
  }
  
 void inicializar () {
 }

  void actualizar () {
      if (lado.equals("ollaDer")) {
        setName ("ollaDer"); // Asignacion de nombre
        setPosition (width - 200 / 2, height -  240 / 2 - 30); // Asignacion de posición
        setGrabbable (false); // ¿Se puede agarrar? *va false
        setStatic (true); // ¿Es estático?
      } else if (lado.equals("ollaIzq")) {
        setName ("ollaIzq"); // Asignacion de nombre
        setPosition (0 + 200 / 2, height -  240 / 2 - 30); // Asignacion de posición
        setGrabbable (false); // ¿Se puede agarrar? *va false
        setStatic (true); // ¿Es estático?
      }
    }
  }
