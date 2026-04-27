/**
 Module Container:
    - Organize modules in a cleaner way.
    - Each entity should hold one of these
 */

class ModuleContainer {
    var modules: [String: Module] = [:]
    
    init(modules: [String: Module]) {
        self.modules = modules
    }
    
    subscript(_ moduleKey: String) -> Module? {
        return modules[moduleKey]
    }
    
    func add(module: Module) {
        let moduleKey = module.moduleKey
        if modules.keys.contains(moduleKey) {
            print("Module \(moduleKey) duplicates.")
        } else {
            modules[moduleKey] = module
        }
    }
}
