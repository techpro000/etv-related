(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d0a3e6b"],{"03c5":function(e,t,i){"use strict";i.r(t);var a=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("el-container",[i("el-main",[i("el-page-header",{attrs:{content:"会议授权设备"},on:{back:e.goBack}}),i("div",{staticClass:"tableTopBar borderNotBottom"},[i("div",{staticClass:"topFrom",staticStyle:{"margin-top":"10px","margin-right":"10px","min-width":"0"}},[i("div",{staticClass:"topFrom-item"},[i("label",[e._v("导出类型:")]),i("div",{staticClass:"topFrom-item-input"},[i("el-select",{attrs:{size:"mini",placeholder:""},model:{value:e.selectValue,callback:function(t){e.selectValue=t},expression:"selectValue"}},e._l(e.options,(function(e){return i("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1)],1)]),i("div",{staticClass:"topFrom-item"},[i("label",[e._v("MAC:")]),i("div",{staticClass:"topFrom-item-input"},[i("el-input",{attrs:{size:"mini",placeholder:"MAC地址"},model:{value:e.mac,callback:function(t){e.mac=t},expression:"mac"}})],1)]),i("div",{staticClass:"topFrom-item"},[i("label",[e._v("日期选择：")]),i("div",{staticClass:"topFrom-item-input"},[i("el-date-picker",{attrs:{"value-format":"yyyy-MM-dd",type:"date",size:"mini",placeholder:"选择日期"},model:{value:e.startTime,callback:function(t){e.startTime=t},expression:"startTime"}})],1),e._v(" --- "),i("div",{staticClass:"topFrom-item-input"},[i("el-date-picker",{attrs:{"value-format":"yyyy-MM-dd",type:"date",size:"mini",placeholder:"选择日期"},model:{value:e.endtTime,callback:function(t){e.endtTime=t},expression:"endtTime"}})],1)]),i("div",{staticClass:"topFrom-item"},[i("label",[e._v("授权平台：")]),i("div",{staticClass:"topFrom-item-input"},[i("el-select",{attrs:{size:"mini"},model:{value:e.PlatformType,callback:function(t){e.PlatformType=t},expression:"PlatformType"}},[i("el-option",{attrs:{value:"",label:"全部"}}),i("el-option",{attrs:{value:"1",label:"飞图"}}),i("el-option",{attrs:{value:"2",label:"宜享"}}),i("el-option",{attrs:{value:"3",label:"宝疆"}}),i("el-option",{attrs:{value:"4",label:"宝泽"}})],1)],1)]),i("div",{staticClass:"topFrom-item"},[i("el-button",{attrs:{type:"primary",icon:"el-icon-search",size:"mini"},on:{click:e.searchInfo}},[e._v("搜索")])],1)]),i("div",{staticClass:"topFrom",staticStyle:{"margin-top":"10px","margin-right":"10px","min-width":"0"}},[i("el-button",{attrs:{type:"primary",plain:"",size:"mini"},on:{click:e.exportPromptDevice}},[e._v("导出宝疆")]),e._e(),i("el-button",{attrs:{type:"primary",size:"mini"},on:{click:e.batchAction}},[e._v("批量激活")]),"1"===e.role.toString()?i("el-button",{attrs:{type:"danger",size:"mini"},on:{click:e.allDelete}},[e._v(" 删除点位 ")]):e._e()],1)]),i("el-table",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],attrs:{data:e.list,border:"",height:"calc(100% - 49px)","header-row-class-name":"tableHead",size:"small",width:"100%"},on:{"selection-change":e.selectM}},[i("el-table-column",{attrs:{type:"selection",align:"center",width:"50"}}),e._l(e.tableType,(function(e,t){return i("el-table-column",{key:t,attrs:{formatter:e.formatter,prop:e.prop,align:"center",label:e.label,width:e.width}})}))],2),i("div",{staticClass:"tablePage borderNotTop"},[i("el-pagination",{attrs:{background:"","page-size":20,"current-page":e.currentPage,layout:"total,prev, pager, next",total:e.total},on:{"current-change":e.onpage}})],1)],1)],1)},n=[],s=i("ed08"),o={name:"dayMeeting",inject:["reload"],data:function(){return{startTime:"",selectValue:"",mac:"",endtTime:"",options:[{label:"全部",value:""},{label:"未授权",value:-1},{label:"已授权",value:1}],currentPage:1,total:0,loading:!1,list:[],selectMeetings:[],tableType:[{prop:"devMac",label:"设备Mac"},{prop:"appKeyType",label:"授权平台",formatter:function(e,t,i){return 1===i?"飞图投屏":2===i?"宜享":4===i?"宝泽":"宝疆"}},{prop:"appKey",label:"授权码"},{prop:"authState",label:"授权状态",formatter:function(e,t,i){return 1===i?"已授权":"未授权"}},{prop:"authTime",label:"授权时间"},{prop:"createTime",label:"操作时间"}],role:this.$cookie.get("roleId"),exportLoading:null,PlatformType:""}},created:function(){this.getResList()},methods:{goBack:function(){this.$router.go(-1)},searchInfo:function(){this.currentPage=1,this.getResList()},getResList:function(){var e=this;this.loading=!0;var t=this.startTime?this.startTime+" 00:00:00":"",i=this.endtTime?this.endtTime+" 00:00:00":"";this.$get("/selectMTAuthInfo.json",{pageNum:this.currentPage,pageSize:20,authState:this.selectValue,cuId:this.$route.query.cuId,appKeyType:this.PlatformType,mac:this.mac,startDate:t,endDate:i}).then((function(t){e.loading=!1,0===t.code?(e.list=t.data&&t.data.list,e.total=t.data?t.data.total:0):e.$elementMessage(t.msg,"error")}))},allDelete:function(){for(var e=this,t=0;t<this.selectMeetings.length;t++)if(1===this.selectMeetings[t].authState)return void this.$elementMessage("不能删除以激活的","error");this.$prompt("请输入操作码","提示",{confirmButtonText:"确定",cancelButtonText:"取消",inputType:"password",inputValidator:function(e){if(null===e)return!1},inputErrorMessage:"请输入操作密码"}).then((function(t){var i=t.value;e.$post("/mappingScreenAuthBatchDel.json",{ids:e.selectMeetings.map((function(e){return e.whiteboardAuthId})).toLocaleString(),pwd:i}).then((function(t){0===t.code?(e.$elementMessage(t.msg,"success"),e.reload()):e.$elementMessage(t.msg,"error")})).catch((function(e){}))})).catch((function(){e.$message({type:"info",message:"取消输入"})}))},clearGssp:function(){for(var e=this,t=0;t<this.selectMeetings.length;t++)if(1===this.selectMeetings[t].authState)return void this.$elementMessage("不能删除以激活的","error");this.$prompt("请输入操作码","提示",{confirmButtonText:"确定",cancelButtonText:"取消",inputType:"password",inputValidator:function(e){if(null===e)return!1},inputErrorMessage:"请输入操作密码"}).then((function(t){var i=t.value;e.$post("/mappingScreenAuthBatchClear.json",{ids:e.selectMeetings.map((function(e){return e.whiteboardAuthId})).toLocaleString(),pwd:i}).then((function(t){0===t.code?(e.$elementMessage(t.msg,"success"),e.reload()):e.$elementMessage(t.msg,"error")})).catch((function(e){}))})).catch((function(){e.$message({type:"info",message:"取消输入"})}))},exportDevice:function(){var e=this;this.exportLoading=this.$loading({lock:!1,text:"加载中",spinner:"el-icon-loading",background:"rgba(0, 0, 0, 0.8)",target:document.querySelector(".el-container")}),this.$post("/exportmappingScreenAuthRec.json",{cusId:this.$route.query.cuId},{responseType:"blob"}).then((function(t){Object(s["c"])(t.data,Object(s["d"])()+".xlsx"),e.$nextTick((function(){e.exportLoading.close()}))})).catch((function(t){e.$nextTick((function(){e.exportLoading.close()})),e.$elementMessage(t,"error")}))},exportPromptDevice:function(){var e=this;this.list<1?this.$elementMessage("设备列表为空","error"):this.$confirm("将导出当前筛选条件下页面数据, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then((function(){e.exportBaojiangDevice()})).catch((function(){}))},exportBaojiangDevice:function(){var e=this;this.exportLoading=this.$loading({lock:!1,text:"加载中",spinner:"el-icon-loading",background:"rgba(0, 0, 0, 0.8)",target:document.querySelector(".el-container")});var t=this.startTime?this.startTime+" 00:00:00":"",i=this.endtTime?this.endtTime+" 00:00:00":"";this.$post("/exportBaojiangScreenAuthRec.json",{cusId:this.$route.query.cuId,authState:this.selectValue,startDate:t,endDate:i,mac:this.mac},{responseType:"blob"}).then((function(t){Object(s["c"])(t.data,"宝疆_"+Object(s["d"])()+".txt"),e.$nextTick((function(){e.exportLoading.close()}))})).catch((function(t){e.$nextTick((function(){e.exportLoading.close()})),e.$elementMessage(t,"error")}))},batchAction:function(){if(this.selectMeetings.length<1)this.$elementMessage("请选择设备","error");else{for(var e=0;e<this.selectMeetings.length;e++)if(1===this.selectMeetings[e].authState||null===this.selectMeetings[e].machineNo||""===this.selectMeetings[e].machineNo)return void this.$elementMessage("设备不能重复激活或MAC为空","error");this.onActivate(this.selectMeetings.map((function(e){return e.whiteboardAuthId.toString()})))}},onActivate:function(e){var t=this;this.$post("/activeWhiteBoardOnlinePoint.json",{ids:e.toString(),cuId:this.$route.query.cuId}).then((function(e){0===e.code?(t.$elementMessage(e.msg,"success"),t.reload()):t.$elementMessage(e.msg,"error")}))},onpage:function(e){this.currentPage=e,this.getResList()},selectM:function(e){this.selectMeetings=e}},components:{}},r=o,l=i("2877"),c=Object(l["a"])(r,a,n,!1,null,"5e0f90d1",null);t["default"]=c.exports}}]);