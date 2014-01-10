#knife plugin viz

Generate dot files illustrating your Chef object relationships.


##Install
`gem install knife-plugin-viz`

##Usage
`knife role viz | dot -Tpng -o roles.png && display roles.png`

`knife cookbook viz --with-versions | dot -Tpng -o cooks.png && display cooks.png`

##Examples
![first example](https://github.com/jjhuff/knife-plugin-role-viz/raw/master/examples/roles1.png)
![second example](https://github.com/jjhuff/knife-plugin-role-viz/raw/master/examples/roles2.png)
