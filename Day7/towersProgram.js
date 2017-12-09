class TowersProgram{
  
  constructor(input){
    this.rows = input.split("\n").map((row) => {return row.replace(/ /g,'').replace(/\(\w+\)/,'');})
  }
  
  bottom_tower(){
    var key,value_section=null;
    var keys = [];
    var values = [];
    
    this.rows.forEach(function(row){
      [key,value_section] = row.split('->');
      if(key)
        keys.push(key);
      if(value_section)
        values = values.concat(value_section.split(","))
    })

    return this.key_with_no_one_depends_on(keys,values);
  }
  
  key_with_no_one_depends_on(keys,values){
    return keys.find(function(key){return values.indexOf(key) === -1;});
  }
}

