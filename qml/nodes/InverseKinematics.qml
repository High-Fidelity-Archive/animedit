import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.6
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import "../fields"

Column {
    id: column
    x: 0
    y: 0
    width: parent.width
    height: (parent.height - 50)
    spacing: 6
    property var modelIndex

    signal fieldChanged(string key, var newValue)

    // called by each field when its value is changed.
    function fieldChangedMethod(key, newValue) {
        var ROLE_DATA = 0x0103;
        var dataValue = theModel.data(modelIndex, ROLE_DATA);
        dataValue[key] = newValue;

        // copy the new value into the model.
        theModel.setData(modelIndex, dataValue, ROLE_DATA);
    }

    // called when a new model is loaded
    function setIndex(index) {
        modelIndex = index;

        var ROLE_DATA = 0x0103;
        var dataValue = theModel.data(modelIndex, ROLE_DATA);

        var fields = ["solutionSource", "solutionSourceVar", "targets"];

        // copy data from theModel into each field.
        var l = fields.length;
        for (var i = 0; i < l; i++) {
            var val = dataValue[fields[i]];
            if (val) {
                column.children[i].value = val;
            }
        }
    }

    Component.onCompleted: {
        // this signal is fired from each data field when values are changed.
        column.fieldChanged.connect(fieldChangedMethod)
    }

    StringField {
        id: solutionSourceField
        key: "solutionSource"
        value: "relaxToUnderPoses"
    }

    StringField {
        id: solutionSourceVarField
        key: "solutionSourceVar"
        value: "solutionSource"
    }

    JSONField {
        id: statesField
        key: "targets"
        value: {}
    }
}

