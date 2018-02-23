import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import Qt.labs.settings 1.0

ApplicationWindow {
    id: app
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    title: qsTr("unik-Launcher")
    property int fs: app.width*0.025
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Settings{
        id: settings
        property string app0: 'aaa'
        property string app1: 'ccc'
        property string app2: 'ddd'
        property string app3: 'ggg'
        property string app4: ''
        property string app5: ''
        property string app6: ''
        property string app7: ''
        property string app8: ''
        property string app9: ''

    }
    Rectangle{
        anchors.fill: parent
        color: "#333"
        ListView{
            id:listApps
            width: parent.width*0.8
            height: parent.height
            model: lmApps
            delegate: delApps
        }
        ListModel{
            id: lmApps
            function add(f){
                return {
                    folder:f
                }
            }
            function actualizar(){
                    clear()
                    for(var i=0;i<10;i++){
                        lmApps.append(lmApps.add(settings['app'+i]))
                    }
            }
        }
        Component{
            id: delApps
            Rectangle{
                width: listApps.width
                height: app.fs*2
                color: "red"
                Text {
                    id: datoFolder
                    text: folder
                    font.pixelSize: parent.height*0.9
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    Component.onCompleted: {
        lmApps.actualizar()
        console.log("OS: "+Qt.platform.os)
        var txt =''
        txt += 'unik version: '+version+'\n'
        txt += 'AppName: '+appName+'\n'
        var e;
        if(unikError!==''){
            txt += '\nErrors:\n'+unikError+'\n'
        }else{
            txt += '\nErrors: none\n'
        }
        //txt += '\nErrors:\n'+unikError+'\n'
        txt += 'Doc location: '+uk.getPath(3)+'/unik\n'
        txt += 'host: '+host+'\n'
        txt += 'user: '+ukuser+'\n'
        txt += 'key: '+ukkey+'\n'
        txt += 'sourcePath: '+sourcePath+'\n'
        txt += '\nconfig.json:\n'+uk.getFile(uk.getPath(3)+'/unik/config.json')+'\n'

        txt += '\nuserhost: ['+userhost+']\n'

       // txtEstado.text = txt
        unik.log(txt)
        if(Qt.platform.os==='windows'){
            var a1 = Screen.desktopAvailableHeight
            var altoBarra = a1-uk.frameHeight(app)
            app.height = a1-altoBarra
        }
    }
}

