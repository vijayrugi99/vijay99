function gt(one ,two)
{
console.log(Date.parse(one)+" "+one);
console.log(Date.parse(two)+" "+two);
return Date.parse(one)>Date.parse(two)
}

function getISOFormat(date)
{
var dts=date.split("/");

return dts[2]+"-"+parseInt(dts[1])+"-"+parseInt(dts[0]);
}
function gt1(one ,two)
{

var one1= getISOFormat(one);
var two1= getISOFormat(two);
console.log(Date.parse(one1)+" "+one1+" "+(new Date(one1)).getTime());
console.log(Date.parse(two1)+" "+two1+" "+(new Date(two1)).getTime());
console.log(Date.parse(one1)>Date.parse(two1));
return Date.parse(one1)>Date.parse(two1)
}