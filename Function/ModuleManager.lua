-- ģ�������
local ModuleManager = {}

-- �洢�Ѽ��ص�ģ��
ModuleManager.loadedModules = {}

-- ����ģ��
function ModuleManager.loadModule(moduleName)
    if not ModuleManager.loadedModules[moduleName] then
        -- �ڴ˿���ִ��ģ��ĳ�ʼ������
        -- if module.init then
        --     module.init()
        -- end
        local module = require(moduleName)
        ModuleManager.loadedModules[moduleName] = module
    else
        release_print("��ģ���ѱ�����", moduleName)
    end
end

-- ж��ģ��
function ModuleManager.unloadModule(moduleName)
    local module = ModuleManager.loadedModules[moduleName]
    if module then
        -- �ڴ˿���ִ��ģ����������
        -- if module.cleanup then
        --     module.cleanup()
        -- end
        ModuleManager.loadedModules[moduleName] = nil
    end
end

-- ʾ�������ز���ʼ������ģ��
function ModuleManager.loadAllModules()
    local modules = {}
    for _, moduleName in ipairs(modules) do
        ModuleManager.loadModule(moduleName)
    end
end

return ModuleManager
