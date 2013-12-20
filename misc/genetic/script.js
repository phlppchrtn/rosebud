// Iteration sur les éléments d'un objet HashMap
function iterateHashMap(hObj, callback) {
  var i = hObj.entrySet().iterator(),
    entry;

  while (i.hasNext()) {
    entry = i.next();
    callback(entry.getKey(), entry.getValue());
  }
}

// Utile pour le débuggage depuis processing
function consoleWrite() {
  console.log.apply(console, arguments);
}

var globalSketch;
function initialize(sketch) {
  globalSketch = sketch;
  setTree(sketch);
}

function setTree(sketch) {
  var map = {
    'modules': [
      ["moduleA", "moduleB", "moduleC"],
      ["moduleD", "moduleE"],
      ["moduleF", "moduleG", "moduleH", "moduleI"],
      ["moduleJ", "moduleK", "moduleL", "moduleM"],
      ["module11", "545", "89765", "32156"]
    ],
    'dependencies': {
      "moduleJ": ["moduleF", "moduleG", "moduleH"],
      "moduleK": ["moduleI"],
      "moduleL": ["moduleH"],
      "moduleM": ["moduleI"],
      "moduleF": ["moduleD", "moduleE"],
      "moduleG": ["moduleE"],
      "moduleH": ["moduleD"],
      "moduleI": ["moduleD", "moduleE"],
      "moduleD": ["moduleA", "moduleB", "moduleC"],
      "moduleE": ["moduleB"],
      "module11": ["moduleL"],
      "545": ["moduleL"]
    }
  };

  // Sauvegarde des liaisons
  for (var key in map.dependencies) {
    sketch.addLiaison(key, map.dependencies[key]);
  }

  // méthode initTree de genetic.pde: Initialisation des éléments à déssiner
  sketch.initTree(map);
}

