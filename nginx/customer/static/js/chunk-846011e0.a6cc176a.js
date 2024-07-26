(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-846011e0"],{"333d":function(e,t,r){"use strict";var a=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"pagination-container",class:{hidden:e.hidden}},[r("el-pagination",e._b({attrs:{background:e.background,"current-page":e.currentPage,"page-size":e.pageSize,layout:e.layout,"page-sizes":e.pageSizes,"pager-count":e.pagerCount,total:e.total},on:{"update:currentPage":function(t){e.currentPage=t},"update:current-page":function(t){e.currentPage=t},"update:pageSize":function(t){e.pageSize=t},"update:page-size":function(t){e.pageSize=t},"size-change":e.handleSizeChange,"current-change":e.handleCurrentChange}},"el-pagination",e.$attrs,!1))],1)},o=[];r("a9e3");Math.easeInOutQuad=function(e,t,r,a){return e/=a/2,e<1?r/2*e*e+t:(e--,-r/2*(e*(e-2)-1)+t)};var n=function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||function(e){window.setTimeout(e,1e3/60)}}();function i(e){document.documentElement.scrollTop=e,document.body.parentNode.scrollTop=e,document.body.scrollTop=e}function l(){return document.documentElement.scrollTop||document.body.parentNode.scrollTop||document.body.scrollTop}function s(e,t,r){var a=l(),o=e-a,s=20,u=0;t="undefined"===typeof t?500:t;var d=function e(){u+=s;var l=Math.easeInOutQuad(u,a,o,t);i(l),u<t?n(e):r&&"function"===typeof r&&r()};d()}var u={name:"Pagination",props:{total:{required:!0,type:Number},page:{type:Number,default:1},limit:{type:Number,default:20},pageSizes:{type:Array,default:function(){return[10,20,30,50]}},pagerCount:{type:Number,default:document.body.clientWidth<992?5:7},layout:{type:String,default:"total, sizes, prev, pager, next, jumper"},background:{type:Boolean,default:!0},autoScroll:{type:Boolean,default:!0},hidden:{type:Boolean,default:!1}},data:function(){return{}},computed:{currentPage:{get:function(){return this.page},set:function(e){this.$emit("update:page",e)}},pageSize:{get:function(){return this.limit},set:function(e){this.$emit("update:limit",e)}}},methods:{handleSizeChange:function(e){this.currentPage*e>this.total&&(this.currentPage=1),this.$emit("pagination",{page:this.currentPage,limit:e}),this.autoScroll&&s(0,800)},handleCurrentChange:function(e){this.$emit("pagination",{page:e,limit:this.pageSize}),this.autoScroll&&s(0,800)}}},d=u,c=(r("96bd"),r("2877")),m=Object(c["a"])(d,a,o,!1,null,"cf1facd6",null);t["a"]=m.exports},3660:function(e,t,r){"use strict";r("f908")},"44b0":function(e,t,r){"use strict";r.r(t);var a=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"accountManagement"},[r("div",{staticClass:"accountManagement-heade"},[r("el-form",{staticClass:"demo-form-inline",attrs:{inline:!0,model:e.queryParams}},[r("el-form-item",{attrs:{label:"人员名称"}},[r("el-input",{model:{value:e.queryParams.userName,callback:function(t){e.$set(e.queryParams,"userName",t)},expression:"queryParams.userName"}})],1),r("el-form-item",{attrs:{label:"角色"}},[r("el-select",{model:{value:e.queryParams.roleId,callback:function(t){e.$set(e.queryParams,"roleId",t)},expression:"queryParams.roleId"}},[r("el-option",{attrs:{label:"销售人员",value:"3"}}),r("el-option",{attrs:{label:"FAE人员",value:"4"}})],1)],1),r("el-form-item",[r("el-button",{attrs:{type:"primary"},on:{click:e.getList}},[e._v("查询")])],1)],1)],1),r("div",{staticClass:"accountManagement-body"},[r("div",{staticClass:"table-btn"},[r("el-button",{attrs:{type:"primary"},on:{click:e.addDialogShow}},[e._v("添加")])],1),r("el-table",{staticStyle:{width:"100%"},attrs:{loading:e.loading,data:e.userList}},[r("el-table-column",{attrs:{prop:"userName",label:"账号名称"}}),r("el-table-column",{attrs:{prop:"nickName",label:"真实姓名"}}),r("el-table-column",{attrs:{prop:"roleId",formatter:e.roleFormatter,label:"角色"}}),r("el-table-column",{attrs:{label:"操作",align:"center",width:"160","class-name":"small-padding fixed-width"},scopedSlots:e._u([{key:"default",fn:function(t){return["admin"!==t.row.userName?r("el-button",{attrs:{size:"mini",type:"text",icon:"el-icon-edit"},on:{click:function(r){return e.handleUpdate(t.row)}}},[e._v("修改 ")]):e._e(),"admin"!==t.row.userName?r("el-button",{attrs:{size:"mini",type:"text",icon:"el-icon-delete"},on:{click:function(r){return e.handleDelete(t.row)}}},[e._v("删除 ")]):e._e()]}}])})],1),r("pagination",{directives:[{name:"show",rawName:"v-show",value:e.total>0,expression:"total>0"}],attrs:{total:e.total,page:e.queryParams.pageNum,limit:e.queryParams.pageSize},on:{"update:page":function(t){return e.$set(e.queryParams,"pageNum",t)},"update:limit":function(t){return e.$set(e.queryParams,"pageSize",t)},pagination:e.getList}})],1),r("el-dialog",{attrs:{"append-to-body":"",title:"添加账号",visible:e.dialogFormVisible},on:{"update:visible":function(t){e.dialogFormVisible=t}}},[r("el-form",{ref:"ruleForm",attrs:{model:e.form,rules:e.rules}},[r("el-row",{attrs:{gutter:20}},[r("el-col",{attrs:{span:12}},[r("el-form-item",{attrs:{label:"账号","label-width":e.formLabelWidth,prop:"userName"}},[r("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.userName,callback:function(t){e.$set(e.form,"userName",t)},expression:"form.userName"}})],1)],1),r("el-col",{attrs:{span:12}},[null===e.form.userId?r("el-form-item",{attrs:{label:"密码","label-width":e.formLabelWidth,prop:"password"}},[r("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.password,callback:function(t){e.$set(e.form,"password",t)},expression:"form.password"}})],1):e._e()],1)],1),r("el-row",{attrs:{gutter:20}},[r("el-col",{attrs:{span:12}},[r("el-form-item",{attrs:{label:"真实姓名","label-width":e.formLabelWidth,prop:"nickName"}},[r("el-input",{attrs:{autocomplete:"off"},model:{value:e.form.nickName,callback:function(t){e.$set(e.form,"nickName",t)},expression:"form.nickName"}})],1)],1),r("el-col",{attrs:{span:12}},[r("el-form-item",{attrs:{label:"角色名称","label-width":e.formLabelWidth,prop:"roleId"}},[r("el-select",{attrs:{placeholder:"请选择活动区域"},model:{value:e.form.roleId,callback:function(t){e.$set(e.form,"roleId",t)},expression:"form.roleId"}},e._l(e.roleOptions,(function(e){return r("el-option",{key:e.roleId,attrs:{label:e.roleName,value:e.roleId,disabled:1==e.status}})})),1)],1)],1)],1)],1),r("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[r("el-button",{on:{click:function(t){return e.onClose()}}},[e._v("取 消")]),r("el-button",{attrs:{type:"primary"},on:{click:function(t){return e.addUserView("ruleForm")}}},[e._v("确 定")])],1)],1)],1)},o=[],n=(r("d3b7"),r("159b"),r("25f0"),r("b775")),i=r("c38a");function l(e){return Object(n["a"])({url:"/system/user/list",method:"get",params:e})}function s(e){return Object(n["a"])({url:"/system/user/"+Object(i["d"])(e),method:"get"})}function u(e){return Object(n["a"])({url:"/system/user",method:"post",data:e})}function d(e){return Object(n["a"])({url:"/system/user",method:"put",data:e})}function c(e){return Object(n["a"])({url:"/system/user/"+e,method:"delete"})}var m=r("333d"),p={data:function(){return{formLabelWidth:"100px",dialogFormVisible:!1,form:{},roleOptions:[],dateRange:[],userList:[],total:0,loading:!1,queryParams:{userName:"",postId:"",pageNum:1,pageSize:10},rules:{userName:[{required:!0,message:"账号不能为空",trigger:["blur","change"]}],password:[{required:!0,message:"密码不能为空",trigger:["blur"]}],nickName:[{required:!0,message:"真实姓名不能为空",trigger:["blur","change"]}],roleId:[{required:!0,message:"角色不能为空",trigger:["blur","change"]}]}}},mounted:function(){this.getList()},methods:{getList:function(){var e=this;this.loading=!0,l(this.addDateRange(this.queryParams,this.dateRange)).then((function(t){e.userList=t.rows,e.total=t.total,e.loading=!1}))},onClose:function(){this.reset(),this.resetForm("ruleForm"),this.dialogFormVisible=!1},handleUpdate:function(e){var t=this;this.form=e,s().then((function(e){t.roleOptions=e.roles,t.roleOptions.forEach((function(e){e.roleId=e.roleId.toString()})),t.form.roleId=t.form.roleId.toString(),t.dialogFormVisible=!0,t.open=!0,t.title="添加用户",t.form.password=t.initPassword}))},handleDelete:function(e){var t=this,r=e.userId||this.ids;this.$modal.confirm('是否确认删除用户编号为"'+r+'"的数据项？').then((function(){return c(r)})).then((function(){t.getList(),t.$modal.msgSuccess("删除成功")})).catch((function(){}))},roleFormatter:function(e){return"1"===e.roleId.toString()?"管理员":"4"===e.roleId.toString()?"FAE售后":"3"===e.roleId.toString()?"销售":void 0},addDialogShow:function(){var e=this;this.dialogFormVisible=!0,this.resetForm("ruleForm"),this.reset(),s().then((function(t){e.roleOptions=t.roles,e.open=!0,e.title="添加用户",e.form.password=e.initPassword}))},reset:function(){this.form={userId:null,deptId:null,userName:null,nickName:null,password:null,phonenumber:null,email:null,sex:null,status:"0",remark:null,postId:"",postIds:[],roleIds:[]},this.resetForm("form")},addUserView:function(e){var t=this;this.form.roleIds=[this.form.roleId],this.$refs[e].validate((function(e){if(!e)return!1;null===t.form.userId?u(t.form).then((function(e){t.dialogFormVisible=!1,t.reset(),t.getList()})):d(t.form).then((function(e){t.dialogFormVisible=!1,t.reset(),t.getList()}))}))}},components:{pagination:m["a"]}},f=p,g=(r("3660"),r("2877")),h=Object(g["a"])(f,a,o,!1,null,"21c1129a",null);t["default"]=h.exports},"810d":function(e,t,r){},"96bd":function(e,t,r){"use strict";r("810d")},f908:function(e,t,r){}}]);