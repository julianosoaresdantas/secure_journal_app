// app/javascript/application.js

import { Application } from "@hotwired/stimulus"
import * as Turbo from "@hotwired/turbo"

// 1. Initialize Stimulus Application
const application = Application.start()

// 2. Robust Dynamic Eager Loading of Stimulus Controllers
//    This code manually inspects the import map to find and register controllers.
//    It serves as a workaround for import.meta.globEager not being a function
//    and eagerLoadControllersFrom not being globally defined.

const importmapScript = document.querySelector('script[type="importmap"]');
if (importmapScript) {
  try {
    const importmap = JSON.parse(importmapScript.textContent);
    const controllerPaths = Object.keys(importmap.imports).filter(path =>
      // Filter for paths that represent your individual controllers
      path.startsWith("controllers/") && path.includes("_controller")
    );

    const registerController = async (path) => {
      try {
        const module = await import(path);
        // Extract identifier: "controllers/hello_controller" -> "hello"
        const identifier = path.replace(/^controllers\//, "").replace(/_controller$/, "");
        // Stimulus controllers are usually default exports (module.default),
        // but for safety, we fallback to module itself if no default.
        application.register(identifier, module.default || module);
        console.log(`Registered Stimulus controller: ${identifier}`);
      } catch (error) {
        console.error(`Failed to load or register controller from ${path}:`, error);
      }
    };

    // Import and register all found controllers concurrently
    Promise.all(controllerPaths.map(registerController))
      .then(() => console.log("All Stimulus controllers attempted to load."))
      .catch(error => console.error("Error during controller eager loading process:", error));

  } catch (error) {
    console.error("Failed to parse importmap JSON or load controllers:", error);
  }
} else {
  console.warn("Import map script not found. Stimulus controllers may not be loaded.");
}

// 3. Initialize Turbo Drive
Turbo.start()

// Optional: Export the application instance for testing/debugging
export { application }
