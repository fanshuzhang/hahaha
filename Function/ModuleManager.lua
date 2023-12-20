-- 模块管理器
local ModuleManager = {}

-- 存储已加载的模块
ModuleManager.loadedModules = {}

-- 加载模块
function ModuleManager.loadModule(moduleName)
    if not ModuleManager.loadedModules[moduleName] then
        -- 在此可以执行模块的初始化操作
        -- if module.init then
        --     module.init()
        -- end
        local module = require(moduleName)
        ModuleManager.loadedModules[moduleName] = module
    else
        release_print("该模块已被定义", moduleName)
    end
end

-- 卸载模块
function ModuleManager.unloadModule(moduleName)
    local module = ModuleManager.loadedModules[moduleName]
    if module then
        -- 在此可以执行模块的清理操作
        -- if module.cleanup then
        --     module.cleanup()
        -- end
        ModuleManager.loadedModules[moduleName] = nil
    end
end

-- 示例：加载并初始化所有模块
function ModuleManager.loadAllModules()
    local modules = {}
    for _, moduleName in ipairs(modules) do
        ModuleManager.loadModule(moduleName)
    end
end

return ModuleManager
