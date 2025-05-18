/*
    COMMANDS: ADDGROUPICON, ADDMPEVENTHANDLER, ALLVARIABLES, CALLEXTENSION, CREATEMINE, CREATETEAM, CREATEUNIT, CTRLCLASSNAME, CTRLMODEL, DISPLAYSETEVENTHANDLER, ENABLECOLLISIONWITH, ENABLEFATIGUE, FORCEADDUNIFORM, LOADFILE, ONEACHFRAME, ONMAPSINGLECLICK, PUBLICVARIABLE, REMOVEALLACTIONS, REMOVEALLITEMS, REMOVEALLMISSIONEVENTHANDLERS, REMOVEALLMPEVENTHANDLERS, REMOVEMPEVENTHANDLER, SETAMMO, SETDAMMAGE, SETFRIEND, SETGROUPICONPARAMS, SETGROUPICONSSELECTABLE, SETGROUPICONSVISIBLE, SETUNITRECOILCOEFFICIENT
*/

class CfgDisabledCommands
{
    class ADDGROUPICON
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"GROUP"},{"ARRAY"}};
        };
    };

    class ADDMPEVENTHANDLER
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"ARRAY"}};
        };
    };

    class ALLVARIABLES
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"CONTROL"}};
        };

        class SYNTAX2
        {
            targets[] = {0,0,0};
            args[] = {{},{"DISPLAY"}};
        };

        class SYNTAX3
        {
            targets[] = {0,0,0};
            args[] = {{},{"TEAM_MEMBER"}};
        };

        class SYNTAX4
        {
            targets[] = {0,1,0}; // Only used for debug console, can be disabled
            args[] = {{},{"NAMESPACE"}};
        };

        class SYNTAX5
        {
            targets[] = {1,1,1};
            args[] = {{},{"OBJECT"}};
        };

        class SYNTAX6
        {
            targets[] = {0,0,0};
            args[] = {{},{"GROUP"}};
        };

        class SYNTAX7
        {
            targets[] = {0,0,0};
            args[] = {{},{"TASK"}};
        };

        class SYNTAX8
        {
            targets[] = {1,1,1};
            args[] = {{},{"LOCATION"}};
        };
    };

    class CALLEXTENSION
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"STRING"},{"STRING"}};
        };

        class SYNTAX2
        {
            targets[] = {0,1,0}; // Only used for debug console, can be disabled
            args[] = {{"STRING"},{"ARRAY"}};
        };
    };

    class CREATEMINE
    {
        class SYNTAX1
        {
            targets[] = {1,0,1};
            args[] = {{},{"ARRAY"}};
        };
    };

    class CREATETEAM
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"ARRAY"}};
        };
    };

    class CREATEUNIT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"STRING"},{"ARRAY"}};
        };

        class SYNTAX2
        {
            targets[] = {1,1,1};
            args[] = {{"GROUP"},{"ARRAY"}};
        };
    };

    class CTRLCLASSNAME
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"CONTROL"}};
        };
    };

    class CTRLMODEL
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"CONTROL"}};
        };
    };

    class DISPLAYSETEVENTHANDLER
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"DISPLAY"},{"ARRAY"}};
        };
    };

    class ENABLECOLLISIONWITH
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"OBJECT"}};
        };
    };

    class ENABLEFATIGUE
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"BOOL"}};
        };
    };

    class FORCEADDUNIFORM
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"STRING"}};
        };
    };

    class LOADFILE
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING"}};
        };
    };

    class ONEACHFRAME
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","CODE"}};
        };
    };

    class ONMAPSINGLECLICK
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"ANY"},{"STRING","CODE"}};
        };

        class SYNTAX2
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","CODE"}};
        };
    };

    // class PUBLICVARIABLE
    // {
    //     class SYNTAX1
    //     {
    //         targets[] = {1,0,1};
    //         args[] = {{},{"STRING"}};
    //     };
    // };

    class REMOVEALLACTIONS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"OBJECT"}};
        };
    };

    class REMOVEALLITEMS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"OBJECT"}};
        };
    };

    class REMOVEALLMISSIONEVENTHANDLERS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING"}};
        };
    };

    class REMOVEALLMPEVENTHANDLERS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"STRING"}};
        };
    };

    class REMOVEMPEVENTHANDLER
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"ARRAY"}};
        };
    };

    class SETAMMO
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"ARRAY"}};
        };
    };

    class SETDAMMAGE
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"SCALAR"}};
        };
    };

    class SETFRIEND
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"SIDE"},{"ARRAY"}};
        };
    };

    class SETGROUPICONPARAMS
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"GROUP"},{"ARRAY"}};
        };
    };

    class SETGROUPICONSSELECTABLE
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"BOOL"}};
        };
    };

    class SETGROUPICONSVISIBLE
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"ARRAY"}};
        };
    };

    class SETUNITRECOILCOEFFICIENT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"OBJECT"},{"SCALAR"}};
        };
    };
};
