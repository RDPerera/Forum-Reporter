type ChannelThread record {|
    string guild_id;
    string id;
    string name;
    anydata...;
|};

type ActiveThreads record {|
    ChannelThread[] threads;
    anydata...;
|};

type Channel record {|
    string guild_id;
    int 'type;
    anydata...;
|};

type Author record {|
    string username;
    anydata...;
|};

type Message record {|
    string content;
    Author author;
    string timestamp;
    anydata...;
|};
