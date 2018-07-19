Class blaisezarka.MigrateSettingsToDefault [ Abstract ]
{
 
/// Migrate all items settings from production <b>productionClassName</b> to system default settings
ClassMethod test(productionClassName As %String) As %Status
{
    set production = ##class(Ens.Config.Production).%OpenId(productionClassName)
    set items = production.Items
    set key = items.Next()
    set tSC = $$$OK
     
    While ((key '= "") && $$$ISOK(tSC)) {
        set item = items.GetAt(key)
        set tSC = ##class(blaisezarka.MigrateSettingsToDefault).CreateDefaultSettings(productionClassName, item)
        set key = items.Next(key)
    }
     
    Quit tSC
}
 
ClassMethod CreateDefaultSettings(productionClassName As %String, item As Ens.Config.Item) As %Status [ Internal ]
{
    Quit:'($IsObject(item)) $$$ERROR("item parameter is not an object")
     
    set settings = item.Settings
    set itemName = item.Name
    set itemClassName = item.ClassName
    set key = settings.Next()
    set tSC = $$$OK
     
    While ((key '= "") && $$$ISOK(tSC)) {
        set setting = settings.GetAt(key)
        set tSC = ##class(blaisezarka.MigrateSettingsToDefault).CreateDefaultSetting(productionClassName, itemClassName, itemName, setting)
        set key = settings.Next(key)
    }
     
    Quit tSC
}
 
ClassMethod CreateDefaultSetting(productionName As %String, itemClassName As %String, itemName As %String, setting As Ens.Config.Setting) As %Status [ Internal ]
{
    Quit:'($IsObject(setting)) $$$ERROR("setting parameter is not an object")
     
    set tSC = $$$OK
     
    if ('(##class(Ens.Config.DefaultSettings).%ExistsId(productionName_"||"_itemName_"||"_itemClassName_"||"_setting.Name)))
    {
        set dsetting = ##class(Ens.Config.DefaultSettings).%New()
        set dsetting.Deployable = 1
        set dsetting.ProductionName = productionName
        set dsetting.HostClassName = itemClassName
        set dsetting.ItemName = itemName
        set dsetting.SettingName = setting.Name
        set dsetting.SettingValue = setting.Value
        set tSC = dsetting.%Save()
    }
     
    Quit tSC
}
 
}