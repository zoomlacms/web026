<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CartByClass.aspx.cs" Inherits="ZoomLaCMS.Cart.CartByClass" MasterPageFile="~/Common/Master/Empty2.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>按分类购物车</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">

<link href="/Template/fruit/style/global.css" rel="stylesheet"/>
<div class="container-fluid catr_quanbu" ng-app="app" ng-controller="appCtrl">
    <div class="row">
        <div class="col-3 cart_left">

            <nav id="node_list">
                <nav class="nav nav-pills flex-column">
                    <a ng-repeat="item in node.list" href="#node-{{item.NodeID}}"  class="nav-link">
                        <span ng-bind="item.NodeName"></span>
                    </a>
                </nav>
            </nav>
             
        </div>


        <div id="pro_list" class="col-9 pro_list" data-spy="scroll" data-target="#node_list" data-offset="10">

			    
            <div ng-repeat="n in node.list">
                <div  id="node-{{n.NodeID}}"></div>
                <div class="item" ng-repeat="item in product.get_bynid(n.NodeID);">
                    <a href="/Shop/{{item.ID}}.aspx">
                        <img ng-src="/uploadfiles/{{item.Thumbnails}}" onerror="this.src='/UploadFiles/nopic.svg';"/>
                    </a>
                    <div class="cart_r">
                        <a href="/Shop/{{item.ID}}.aspx"><span ng-bind="item.Proname"></span></a><span ng-bind="item.Weight*1000"></span>g    
                        <span ng-bind="item.LinPrice|number:2" class="cart_pric"></span>
                        <button type="button" class="btn btn-light btn-xs pull-right cart_jia" ng-click="product.addToCart(item);">	<span class="fa-stack fa-lg">
								  <i class="fa fa-circle fa-stack-2x jia_r"></i>
								  <i class="fa  fa-cart-plus fa-stack-1x fa-inverse"></i>
								</span></button>
                    </div>
                </div>
            </div>
        </div>

    </div>

	
    <div class="fixed-bottom">
        <a href="/Cart/Cart.aspx?Proclass=1" id="icon-cart"></a>
        <span class="badge badge-pill badge-danger cat_d" ng-bind="cart.getTotalNum();"></span>
    </div>
</div>


<div class="h_bottom_nav">
<ul class="container d-flex justify-content-around">
	<li class="bd-highlight"><a href="<%Call.Label("{ZL:GetNodeLinkUrl(2)/}"); %>" ><i class="fa fa-home" aria-hidden="true"></i><span>首页</span></a></li>
	<li class="bd-highlight"><a href="<%Call.Label("{ZL:GetNodeLinkUrl(10)/}"); %>"><i class="fa fa-flickr" aria-hidden="true"></i><span>活动</span></a></li>
	<li class="bd-highlight"><a href="/Cart/Cart.aspx?Proclass=1" ><i class="fa z01-icon092" aria-hidden="true"></i><span>买菜</span> </a></li>
	<li class="bd-highlight"><a href="<%Call.Label("{ZL:GetNodeLinkUrl(5)/}"); %>"><i class="fa fa-calendar-minus-o" aria-hidden="true"></i><span>菜谱</span></a></li>
	<li class="bd-highlight"><a href="/wxpromo.aspx?r=/User" class="active"><i class="fa fa-user" aria-hidden="true"></i><span>我</span></a></li>
</ul>
<div class="clearfix"></div>
</div>
	<!--buttom end-->
	
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style type="text/css">
*{font-size:12px;}

</style>
<link rel="stylesheet" href="/dist/css/swiper.min.css"/>
<script src="/dist/js/swiper.min.js"></script>
<script src="/JS/Plugs/angular.min.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<script src="/JS/Modal/APIResult.js"></script>
<script src="/JS/Plugs/fly.js"></script>
<script src="/JS/Plugs/requestAnimationFrame.js"></script>

<script>
    var swiper = new Swiper('.swiper-container', {
        autoplay: 4000,
        pagination: '.swiper-pagination',
        paginationClickable: true,
        grabCursor: true,
        loop: true
    });
    angular.module("app", []).controller("appCtrl", function ($scope) {
        $("#pro_list").height($(document).height()-80);
        $scope.node = {active:null, list: <%=nodeJson%> };
        $scope.node.setActive=function(node){
            $scope.node.active=node;
            $scope.product.reload();
        }
        $scope.node.get_nodes=function(pid){
            var nodeArr=[];
            var list=$scope.node.list;
            for (var i = 0; i < list.length; i++) {
                var node=list[i];
                if(node.ParentID!=pid){continue;}
                nodeArr.push(node);
            }
            return nodeArr;
        }
        $scope.node.get_active_nodes=function(){
            var ref=this;
            if(ref.active==null){return [];}
            else {return ref.get_nodes(ref.active.NodeID);}
        }
        //------------------------
        $scope.product = { list: <%=productJson%>,sliders:[] };
        //加载商品数据
        $scope.product.reload=function(){
            var ref=this;
            $.post("CartByClass.aspx?action=product_list",{"nid":$scope.node.active.NodeID},function(data){
                var model=APIResult.getModel(data);
                if(APIResult.isok(model)){
                    ref.list=model.result;
                }
                $scope.$digest();
            })
        }
        $scope.product.get_bynid=function(nid){
            var ref=this;
            var proArr=[];
            for (var i = 0; i < ref.list.length; i++) {
                if(ref.list[i].NodeID==nid){proArr.push(ref.list[i]);}
            }
            return proArr;
        }
        //加入购物车
        $scope.product.addToCart=function(item){
            var offset = $("#icon-cart").offset();
            var flyer = $('<img class="flyer-img" src="/Images/copy.png" style="width:20px;height:20px;">'); // //抛物体对象
            flyer.fly({
                start: {
                    left: event.pageX,
                    top: (event.pageY - $(window).scrollTop())//y需要减去减动条
                },
                end: {
                    left: offset.left + 10,
                    top: offset.top + 10,
                    width: 0, //结束时宽度
                    height: 0 //结束时高度
                },
                onEnd: function () {
                    flyer.remove();
                }
            });
            $scope.cart.add(item.ID,1);
        }
        //------------------------
        $scope.cart={list:<%=cartJson%>};
        //增加数量
        $scope.cart.add=function(id,num){
            var ref=this;
            $.post("/Cart/Cart.aspx?id="+id+"&pronum="+num,{},function(data){
            
            })
            //----修改缓存中的数量
            var model=ref.getFromList(id);
            if(model==null){ref.list.push({ID:0,"ProID":id,"Pronum":num});}
            else{model.Pronum+=num;}
        }
        $scope.cart.getFromList=function(proid){
            var ref=this;
            for (var i = 0; i < ref.list.length; i++) {
                if(ref.list[i].ProID==proid){return ref.list[i];}
            }
            return null;
        }
        //返回所有商品的总数
        $scope.cart.getTotalNum=function(){
            var ref=this;
            var total=0;
            for (var i = 0; i < ref.list.length; i++) {
                total+=ref.list[i].Pronum;
            }
            return Convert.ToInt(total);
        }
    })
</script>
</asp:Content>