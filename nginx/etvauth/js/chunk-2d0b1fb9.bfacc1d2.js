(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d0b1fb9"],{"21bf":function(e,t,a){"use strict";a.r(t);var i=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("el-container",[a("el-main",[a("div",{directives:[{name:"show",rawName:"v-show",value:"1"===e.role,expression:"role==='1'"}],staticClass:"tableTopBar borderNotBottom"},[a("div",{staticStyle:{display:"flex","align-items":"center","justify-content":"center"}},[a("el-input",{staticStyle:{"margin-right":"10px"},attrs:{size:"mini",placeholder:"公司名"},model:{value:e.companyName,callback:function(t){e.companyName=t},expression:"companyName"}}),a("el-input",{staticStyle:{"margin-right":"10px"},attrs:{size:"mini",placeholder:"手机号"},model:{value:e.phone,callback:function(t){e.phone=t},expression:"phone"}}),a("el-input",{staticStyle:{"margin-right":"10px"},attrs:{size:"mini",placeholder:"APPID"},model:{value:e.appId,callback:function(t){e.appId=t},expression:"appId"}}),a("el-button",{attrs:{type:"primary",icon:"el-icon-search",size:"mini"},on:{click:e.searchInfo}},[e._v("搜索")])],1),a("div",{staticClass:"topFrom",staticStyle:{"margin-top":"10px","margin-right":"10px","min-width":"0"}},[a("div",{staticClass:"topFrom-item"},[a("label",[e._v("导出类型:")]),a("div",{staticClass:"topFrom-item-input"},[a("el-select",{attrs:{size:"mini",placeholder:"请选择"},on:{change:e.selectValueChange},model:{value:e.type,callback:function(t){e.type=t},expression:"type"}},e._l(e.options,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1)],1)]),a("div",{staticClass:"topFrom-item"},[a("label",[e._v("导出时间：")]),a("div",{staticClass:"topFrom-item-input"},[a("el-date-picker",{attrs:{type:"month",size:"mini",placeholder:"选择月"},model:{value:e.dateStr,callback:function(t){e.dateStr=t},expression:"dateStr"}})],1)]),a("div",{staticClass:"topFrom-item"},[a("el-button",{attrs:{type:"primary",icon:"el-icon-download",size:"mini"},on:{click:e.exportInfo}},[e._v("导出")]),a("el-button",{attrs:{type:"primary",size:"mini"},on:{click:e.toInventoryList}},[e._v("库存")])],1)])]),a("el-table",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticStyle:{width:"100%"},attrs:{data:e.list,border:"",height:"calc(100% - 49px)","header-row-class-name":"tableHead",size:"small"},on:{"selection-change":e.selectM}},[a("el-table-column",{attrs:{type:"selection",align:"center",width:"50"}}),e._l(e.tableType,(function(e,t){return a("el-table-column",{key:t,attrs:{formatter:e.formatter,prop:e.prop,align:"center",label:e.label,width:e.width}})}))],2),a("div",{staticClass:"tablePage borderNotTop"},[a("el-pagination",{attrs:{background:"","page-size":20,"current-page":e.currentPage,layout:"total,prev, pager, next",total:e.total},on:{"current-change":e.onpage}})],1)],1)],1)},n=[],o=a("ed08"),l={name:"dayMeeting",data:function(){return{dateStr:"",type:"",role:this.$cookie.get("roleId"),options:[{label:"已分配",value:1},{label:"已授权",value:2}],companyName:"",phone:"",appId:"",currentPage:1,total:0,loading:!1,list:[],selectMeetings:[],tableType:[{prop:"name",label:"客户名"},{prop:"phone",label:"手机号"},{prop:"appId",label:"APPID"},{prop:"companyName",label:"公司名"},{prop:"totalNum",label:"已注册数"},{prop:"lastPhoneFee",label:"剩余话费"},{prop:"createTime",label:"创建时间"},{prop:"operate",label:"操作",width:"250",formatter:this.thumb}]}},created:function(){this.getResList()},methods:{searchInfo:function(){this.currentPage=1,this.getResList()},exportInfo:function(){""!==this.type?this.dateStr?window.location.href=o["b"]+"/exportHongRuanInfoAuthRec.json?type="+this.type+"&dateStr="+this.dateStr:this.$elementMessage("请选择导出时间","error"):this.$elementMessage("请选择导出类型","error")},toInventoryList:function(){this.$router.push({path:"/tokenInventory"})},selectValueChange:function(){},getResList:function(){var e=this;this.loading=!0,this.$get("/selectAllCallPhoneCustomer.json",{pageNo:this.currentPage,cuId:this.$cookie.get("userId"),companyName:this.companyName,phone:this.phone,pageSize:20,appId:this.appId}).then((function(t){e.loading=!1,0===t.code?(e.list=t.data.list,e.total=t.data.sumNum):e.$elementMessage(t.msg,"error")}))},toAlarmDeviceList:function(e){this.$router.push({path:"/alarmDeviceList",query:{id:e.id}})},onpage:function(e){this.currentPage=e,this.getResList()},selectM:function(e){this.selectMeetings=e},thumb:function(e){var t=this,a=this.$createElement;return a("div",[a("el-button",{attrs:{size:"mini",type:"primary"},on:{click:function(){return t.toAlarmDeviceList(e)}}},["报警电话设备"])])}},components:{}},r=l,s=a("2877"),c=Object(s["a"])(r,i,n,!1,null,"043f1eba",null);t["default"]=c.exports}}]);