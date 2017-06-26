[DEPRECATED] facts
==================

NOTE: This repository is no longer maintained
---------------------------------------------


This module allows you to create Puppet Facts using Puppet code or your Hiera backend.

This can be useful to document your machines or even your Puppet classes. A class could for example create it's own Fact, which when queried by a different class, could determine if the class has been applied to the machine or any other state that might be interesting to report.

Usage
-------

In your Hiera YAML, do something like:

```
facts::external::instance: { server_comment: { value: "Dont reboot me!" } }
```

or:

```
facts::external::instance:
  server_comment:
    value: "Dont reboot me!"
```

The Defined Type is available as facts::external, allowing your Puppet classes to create arbitrary Puppet Facts. e.g.

```
facts::instance { 'mypuppetclass_applied':
  value => true,
}
facts::instance { 'mypuppetclass_applied_timestamp':
  value => strftime("%Y-%m-%d"),
}
```

For Windows nodes, we must specify a facterpath:

```
facts::external::instance:
  server_comment:
    value: "Dont reboot me!"
    facterpath: 'C:/ProgramData/PuppetLabs/facter/facts.d'
```

Support
-------

Please log tickets and issues at our [Projects site](http://github.com/meltwater/puppet-facts)
