<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CartByClass.aspx.cs" Inherits="ZoomLaCMS.Cart.CartByClass" MasterPageFile="~/Common/Master/Empty2.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>按分类购物车</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">

<link href="/Template/fruit/style/global.css" rel="stylesheet"/>
<div class="container-fluid" ng-app="app" ng-controller="appCtrl">
    <div class="row">
        <div class="col-3" style="padding:0px;">
          <ul id="node_list" class="list-unstyled">
              <li ng-repeat="item in node.get_nodes(0)" ng-class="item==node.active?'active':''" ng-click="node.setActive(item);">
                  <span ng-bind="item.NodeName"></span>
              </li>
			      <div class=" pro_nodes">
                <a ng-repeat="item in node.get_active_nodes()" href="javascript:;" ng-bind="item.NodeName" class="btn btn-outline-info" style="margin-right:5px;margin-bottom:5px;"></a>
            </div>
				 
          </ul>   
        </div>
      <!--  <div class="col-9" >
<!--            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" ng-repeat="item in product.sliders">
                        <a href="javascript:;">
                            <img ng-src="{{item.image}}" style="max-width:100%;"/>
                        </a>
                        <h3><a href="javascript:;" ng-bind="item.name"></a></h3>
                    </div>
                </div>
                <div class="swiper-pagination swiper-pagination-white"></div>
            </div>-->
            <div class="col-3 pro_nodes" hidden>
                <a ng-repeat="item in node.get_active_nodes()" href="javascript:;" ng-bind="item.NodeName" class="btn btn-outline-info" style="margin-right:5px;margin-bottom:5px;"></a>
            </div>
            <div class="col-9 pro_list">
                <div class="item" ng-repeat="item in product.list">
				<a href='/shop/<span ng-bind="item.ID"></span>'>
				
				
				<img ng-src="{{item.Thumbnails}}" onerror="this.src='/UploadFiles/nopic.svg';" style="width:4rem;height:4rem;position:absolute;"/></a>
                    <div style="margin-left:55px;">
                        <span ng-bind="item.Proname"></span> <span ng-bind="item.Weight"></span>g    
                        <span ng-bind="item.LinPrice|number:2" style="color: red;"></span>
                        <button type="button" class="btn btn-info btn-xs pull-right" style="margin-right:8px;" ng-click="product.addToCart(item);"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
      
    </div>
    <div class="fixed-bottom" style="width:100%;height:50px;line-height:50px;background-color:#ff6a00;text-align:center;">
        <a href="/Cart/Cart.aspx?Proclass=1" style="font-size:2rem;" id="icon-cart"><i class="fa fa-shopping-cart"></i></a>
        <span class="badge badge-pill badge-danger" ng-bind="cart.getTotalNum();"></span>
    </div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style type="text/css">
*{font-size:12px;}
#node_list li{display:block;margin-bottom:3px;padding:5px 8px;border:1px solid #ddd;}
#node_list li.active{color:#fff;background-color:#0094ff;}
.pro_list .item{height:60px;}
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
        $scope.product = { list: [],sliders:[] };
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
        //加入购物车
        $scope.product.addToCart=function(item){
            var offset = $("#icon-cart").offset();
            var flyer = $('<img class="flyer-img" src="/Images/copy.png" style="width:15px;height:15px;">'); // //抛物体对象
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
        //------------------------
        $scope.product.sliders.push({name:"",image:"/UploadFiles/slider1.jpg"});
        $scope.product.sliders.push({name:"",image:"/UploadFiles/slider2.jpg"});
        $scope.product.sliders.push({name:"",image:"/UploadFiles/slider3.jpg"});
        $scope.node.setActive($scope.node.get_nodes(0)[0]);
    })
</script>
</asp:Content>