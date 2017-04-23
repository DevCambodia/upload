<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="asva" ng-controller="mainCtrl">
<head>

<jsp:include page="fragment/header-component.jsp">
	<jsp:param value="ASSVA USER" name="pageTitle" />
	<jsp:param value="ASSVA ADMIN" name="pageDescription" />
	<jsp:param value="ASSVA" name="author" />
</jsp:include>

<style>
.btn-add-fixed {
	position: fixed;
	bottom: 30px;
	right: 40px;
}

#addStyle .bootstrap-select:not ([class*="col-"] ):not ([class*="form-control"]
	):not (.input-group-btn ){
	width: 100%;
}

.file-chooser {
	display: none !important;
}

.item-img {
	width: 130px;
	height: 130px;
}
</style>
<script src="//cdn.ckeditor.com/4.5.10/standard/ckeditor.js"></script>
</head>
<body>

	<div class="nav-bar-container">
		<jsp:include page="fragment/navigation.jsp"></jsp:include>
	</div>
	<input type="hidden" id="context-path" value="${pageContext.request.contextPath}">
	<div class="content">

		<!--BEGIN HEADER  -->
		<div class="page-header full-content">
			<jsp:include page="fragment/header.jsp">
				<jsp:param value="PRODUCT MANAGEMENT" name="pageName" />
			</jsp:include>
		</div>
		<!--.full-content  -->


		<div class="display-animation">
			<div class="row">
				<div class="col-md-12">
					<div class="panel indigo">
						<div class="panel-heading">
							<div class="panel-title">
								<h4>ALL PRODUCTS</h4>

							</div>
							<!--.panel-title  -->
						</div>
						<!--.panel-heading-->
						<div class="panel-body">
							<div class="row" id="ACTION">
								<!-- Limit -->
								<div class="col-md-1">
									<select name="example1_length" ng-model="lim"
										ng-change="limitClick(lim)" aria-controls="example1"
										class="form-control input-sm">
										<option value="10" ng-selected="true">10</option>
										<option value="25">25</option>
										<option value="50">50</option>
										<option value="100">100</option>
									</select>
								</div>
								<!-- Main category -->
								<div class="col-md-2">
									<div class="dataTables_length" id="example1_length">
										<select ng-model="catFilter" aria-controls="example1"
											ng-change="mainChange(catFilter)"
											class="form-control input-sm">
											<option ng-selected="true" value="">All</option>
											<option
												ng-repeat="c in cats | filter:{'MAIN_CATEGORY': null, 'CATEGORY_STATUS': 1}"
												ng-value="c.ID" ng-bind="c.CATEGORY_NAME"></option>
										</select>
									</div>
								</div>
								<!-- sub category -->
								<div class="col-sm-2" ng-show="showSub">
									<div class="dataTables_length">
										<select ng-model="subFilter" aria-controls="example1"
											class="form-control input-sm">
											<option ng-repeat="c in cats"
												ng-if="c.MAIN_CATEGORY.ID==catFilter" ng-value="c.ID"
												ng-bind="c.CATEGORY_NAME"></option>
										</select>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="input-group input-group-sm" style="width: 150px;">
										<input type="text" name="table_search" ng-model="s"
											ng-change="searchItem(s)" class="form-control pull-right"
											placeholder="Search">

										<div class="input-group-btn">
											<button type="button" class="btn btn-default">
												<i class="fa fa-search"></i>
											</button>
										</div>
									</div>
								</div>
								<div class="col-sm-1">
									<div class="input-group input-group-sm" style="width: 150px;">

										<button type="button" class="btn btn-block btn-primary"
												data-toggle="modal" data-target="#myModal">
											<span class="glyphicon glyphicon-plus"></span>
										</button>

									</div>
								</div>
							</div>

							<!-- <div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>Item</th>
											<th>Price</th>
											<th>Date</th>
											<th>Status</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="i in items" ng-show="i.ITEM_STATUS!=3"
											ng-if="i.ITEM_CATEGORY.ID==subFilter || all==true">
											<td>{{i.ITEM_NAME}}</td>
											<td>$ {{i.ITEM_PRICE}}</td>
											<td>{{i.ITEM_PUBLISH_DATE}}</td>
											<td style="text-align: center;"><span
												ng-show="i.ITEM_IS_SOLD==false" class="label label-success">Available</span>
												<span ng-show="i.ITEM_IS_SOLD==true"
												class="label label-danger">Sold</span> <span
												ng-show="i.ITEM_STATUS==0" class="label label-warning">Hidden</span>
											</td>
											<td style="text-align: center;">
												<div class="btn-group">
													Change Product Status
													<button type="button" class="btn btn-warning"
														title="Change product to show or hide."
														ng-click="changeState(i)">
														<span ng-show="i.ITEM_STATUS==0"
															class="glyphicon glyphicon-eye-open"></span> <span
															ng-show="i.ITEM_STATUS==1"
															class="glyphicon glyphicon-eye-close"></span>
													</button>
													Change Product to Sold
													<button type="button" class="btn btn-info"
														ng-click="updateProSold(i)"
														title="Change product to sold or not.">
														<span ng-show="i.ITEM_IS_SOLD==true"
															class="glyphicon glyphicon-ok-circle"></span> <span
															ng-show="i.ITEM_IS_SOLD==false"
															class="glyphicon glyphicon-remove-circle"></span>
													</button>
													Edit Product
													<button type="button" class="btn btn-success"
														ng-click="edit(i)" title="Update product information."
														data-toggle="modal" data-target="#myModal">
														<span class="glyphicon glyphicon-pencil"></span>
													</button>
													Delete Product
													<button type="button" class="btn btn-danger"
														ng-click="deletePro(i)" title="Delete product">
														<span class="glyphicon glyphicon-trash"></span>
													</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div> -->

							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>Item</th>
											<th>Price</th>
											<th>Telephone</th>
											<th>Date</th>
											<th>Status</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="i in items" ng-show="i.ITEM_STATUS!=3"
											ng-if="i.ITEM_CATEGORY.ID==subFilter || all==true && i.ITEM_CATEGORY.CATEGORY_STATUS==1">
											<td>{{splitRec(i.ITEM_NAME,0)}}</td>
											<td>{{i.ITEM_PRICE}}</td>
											<td>{{splitRec(i.ITEM_NAME,1)}}</td>
											<td>{{i.ITEM_PUBLISH_DATE}}</td>
											<td style="text-align: center;"><span
												ng-show="i.ITEM_IS_SOLD==false" class="label label-success">Available</span>
												<span ng-show="i.ITEM_IS_SOLD==true"
												class="label label-danger">Sold</span> <span
												ng-show="i.ITEM_STATUS==0" class="label label-warning">Hidden</span>
											</td>
											<td style="text-align: center;">
												<div class="btn-group">
													<!-- Change Product Status -->
													<button type="button" class="btn btn-warning"
														title="Change product to show or hide."
														ng-click="changeState(i)">
														<span ng-show="i.ITEM_STATUS==0"
															class="glyphicon glyphicon-eye-open"></span> <span
															ng-show="i.ITEM_STATUS==1"
															class="glyphicon glyphicon-eye-close"></span>
													</button>
													<!-- Change Product to Sold -->
													<button type="button" class="btn btn-info"
														ng-click="updateProSold(i)"
														title="Change product to sold or not.">
														<span ng-show="i.ITEM_IS_SOLD==true"
															class="glyphicon glyphicon-ok-circle"></span> <span
															ng-show="i.ITEM_IS_SOLD==false"
															class="glyphicon glyphicon-remove-circle"></span>
													</button>
													<!-- Edit Product -->
													<button type="button" class="btn btn-success"
														ng-click="edit(i)" title="Update product information."
														data-toggle="modal" data-target="#myModal">
														<span class="glyphicon glyphicon-pencil"></span>
													</button>
													<!-- Delete Product -->
													<button type="button" class="btn btn-danger"
														ng-click="deletePro(i)" title="Delete product">
														<span class="glyphicon glyphicon-trash"></span>
													</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- /.box-b						
	
							<!-- Panel Footer -->
							<div class="panel-footer" style="text-align: center;">
								<ul class="pagination">
									<li ng-repeat="i in totalItems track by $index"
										ng-if="$index<totalPage"
										ng-class="($index+1)==page?'active':''"
										ng-click="goToPage($index+1)"><a href>{{$index+1}}</a></li>
								</ul>
							</div>


							<!-- <div class="row">
								<div class="col-md-6">
									<div id="INFORMATION">Showing {{paging.currentPage}} to
										{{paging.limit}} of {{paging.totalRecords}} entries</div>
									<select class="selectpicker" ng-change="rowChange(row)"
										ng-model="row">
										<option ng-repeat="row in rows" ng-value="row" ng-bind="row"></option>
									</select>
								</div>
								<div class="col-md-6">
									<div id="PAGINATION" class="pull-right"></div>
								</div>
							</div> -->

						</div>
						<!--.panel-body-->
					</div>
					<!--.panel-->
				</div>
			</div>
			<!--.row-->
		</div>
		<!--.display-animation-->

		<!-- <form class="modal fade" id="myModal" data-keyboard="false"
			name="proForm" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							ng-click="clearForm()" aria-label="Close">
							<span aria-hidden="true" class="glyphicon glyphicon-remove"></span>
						</button>
						<h4 class="modal-title">
							<span ng-show="isEdit==false">Add Product</span> <span
								ng-show="isEdit==true">Update Product</span>
						</h4>
					</div>
					<div class="modal-body">
						<div class="box-body">
							<div class="form-group">
								<label for="catModel">Category</label> <select
									class="form-control input-sm" ng-model="catModel">
									<option ng-repeat="c in cats" ng-if="c.MAIN_CATEGORY!=null"
										ng-value="c.ID" ng-bind="c.CATEGORY_NAME"
										ng-selected="editObject.ITEM_CATEGORY.ID==c.ID"></option>
								</select>
							</div>
							<div class="form-group">
								<label for="proNameModel">Name</label> <input type="text"
									class="form-control" id="proNameModel" ng-model="proNameModel"
									ng-required="true" placeholder="Enter product name">
								<p ng-show="proForm.proNameModel.$error.required">Product
									name is required.</p>
							</div>
							<div class="form-group">
								<label for="proDescModel">Description</label>
								<textarea type="text" class="form-control" id="proDescModel"
									ng-model="proDescModel" placeholder="Product Description"></textarea>
							</div>
							<div class="form-group">
								<label for="proPriceModel">Price</label> <input type="text"
									ng-required="true" only-digits class="form-control"
									id="proPriceModel" ng-model="proPriceModel"
									placeholder="Price ($)">
								<p ng-show="proForm.proPriceModel.$error.required">Product
									price is required.</p>
							</div>
							<div class="form-group">
								<label for="proImageModel">Upload Image</label> <input
									type="file" id="proImageModel">
								<p class="help-block">Please choose image of product.</p>

							</div>
							<div class="form-group">
								<label for="proImage">Image From URL</label> <input type="text"
									class="form-control" ng-model="proImage" id="proImage"
									placeholder="Image Url..." ng-change="setImage()">

							</div>
							image display
							<div class="form-group">
								<img style="min-width: 200px; min-height: 200px;" width="200"
									height="200" class="img-thumbnail" id="proImg" src="" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default pull-left"
							data-dismiss="modal" id="btnClose">Close</button>
						<button type="button" class="btn btn-primary"
							ng-click="operation()" ng-disabled="proForm.$invalid">Save</button>
					</div>
				</div>
				/.modal-content
			</div>
			/.modal-dialog
		</form> -->

		<form class="modal fade" id="myModal" data-keyboard="false"
			name="proForm" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							ng-click="clearForm()" aria-label="Close">
							<span aria-hidden="true" class="glyphicon glyphicon-remove"></span>
						</button>
						<h4 class="modal-title">
							<span ng-show="isEdit==false">Add Product</span> <span
								ng-show="isEdit==true">Update Product</span>
						</h4>
					</div>
					<div class="modal-body">
						<div class="box-body">
							<div class="form-group">
								<label for="catModel">Category</label> <select
									class="form-control input-sm" ng-model="catModel" id="catModel">
									<option value="">-- Select Category --</option>
									<option ng-repeat="c in cats"
										ng-if="c.MAIN_CATEGORY!=null && c.CATEGORY_STATUS==1"
										ng-value="c.ID" ng-bind="c.CATEGORY_NAME"
										ng-selected="editObject.ITEM_CATEGORY.ID==c.ID"></option>
								</select>
							</div>
							<div class="form-group">
								<label for="proNameModel">Name</label> <input type="text"
									class="form-control" id="proNameModel" ng-model="proNameModel"
									ng-required="true" placeholder="Enter product name">
								<p ng-show="proForm.proNameModel.$error.required">Product
									name is required.</p>
							</div>
							<div class="form-group">
								<label id="proDescModels">Description</label>
								<textarea type="text" class="form-control" id="proDescModel"
									name="proDescModel" ng-model="proDescModel"
									placeholder="Product Description"></textarea>
							</div>
							<div class="form-group">
								<label for="proPriceModel">Price</label> <input type="text"
									ng-required="true" class="form-control"
									id="proPriceModel" ng-model="proPriceModel"
									placeholder="Price ($)">
								<p ng-show="proForm.proPriceModel.$error.required">Product
									price is required.</p>
							</div>
							<div class="form-group">
								<label for="proTelModel">Telephone</label> <input type="text"
									class="form-control" id="proTelModel" ng-model="proTelModel"
									ng-required="true" placeholder="Enter telephone">
							</div>
							<div class="form-group">
								<label>Product Image</label> <input type="file"
									id="proImageModel0" class="file-chooser">
								<!-- <p class="help-block">Please choose thumbnail of product.</p> -->
							</div>
							<!-- image display -->
							<div class="form-group">
								<div class="row">
									<div class="col-sm-4"></div>
									<div class="col-sm-4">
										<img style="min-width: 200px; min-height: 200px;" width="200"
											height="200" class="img-thumbnail" id="proImg0"
											src="${pageContext.request.contextPath}/resources/images/thumbnail-default.jpg"
											ng-click="browseImage(0)" />
									</div>
									<div class="col-sm-4"></div>
								</div>

							</div>

							<!-- item image  -->
							<div class="form-group">

								<input type="file" id="proImageModel1" class="file-chooser">
								<input type="file" id="proImageModel2" class="file-chooser">
								<input type="file" id="proImageModel3" class="file-chooser">
								<input type="file" id="proImageModel4" class="file-chooser">
								<div class="row">
									<div class="col-sm-3">
										<img height="200" class="form-control img-thumbnail item-img"
											id="proImg1" ng-click="browseImage(1)"
											src="${pageContext.request.contextPath}/resources/images/thumbnail-default.jpg" />
									</div>
									<div class="col-sm-3">
										<img height="200" class="form-control img-thumbnail item-img"
											id="proImg2" ng-click="browseImage(2)"
											src="${pageContext.request.contextPath}/resources/images/thumbnail-default.jpg" />
									</div>
									<div class="col-sm-3">
										<img height="200"
											class="col-sm-3 form-control img-thumbnail item-img"
											id="proImg3" ng-click="browseImage(3)"
											src="${pageContext.request.contextPath}/resources/images/thumbnail-default.jpg" />
									</div>
									<div class="col-sm-3">
										<img height="200"
											class="col-sm-3 form-control img-thumbnail item-img"
											id="proImg4" ng-click="browseImage(4)"
											src="${pageContext.request.contextPath}/resources/images/thumbnail-default.jpg" />
									</div>
								</div>

							</div>
							<!-- <div class="form-group">
								<label for="proImages">Product Images</label> 
								<input type="file"
									id="proImages" multiple="multiple">
								<p class="help-block">Please choose image of product.</p>
							</div> -->

							<!-- <div class="form-group">
								<label for="proImage">Image From URL</label> <input type="text"
									class="form-control" ng-model="proImage" id="proImage"
									placeholder="Image Url..." ng-change="setImage()">

							</div> -->

						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default pull-left"
							data-dismiss="modal" id="btnClose">Close</button>
						<button type="button" class="btn btn-primary"
							ng-click="operation()" ng-disabled="proForm.$invalid">Save</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</form>

		<!--BEGIN BUTTON ADD  -->
		<!-- <div class="btn-add-fixed">
			<a data-target="#addUserModal" data-toggle="modal"
				class="btn btn-indigo btn-ripple"><i class="ion-android-add"></i></a>
		</div> -->

		<!--BEGIN ADD USER MODAL  -->
		<!-- <div class="modal scale fade" id="addUserModal" tabindex="-1"
			role="dialog" aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">
							<i class="glyphicon glyphicon-user"></i> ADD USER
						</h4>
						<hr>
					</div>
					<div class="modal-body">

						<div class="row">
							<div class="col-md-12" id="addStyle">
								<select class="selecter" style="display: none;">
									<option value="">All Products</option>
									<option value="false">Available</option>
									<option value="true">Sold</option>
								</select>
							</div>
						</div>

						<div class="inputer floating-label">
							<div class="input-wrapper">
								<input type="text" class="form-control" id="lastname" required>
								<label for="lastname">Last Name</label>
							</div>
						</div>
						<div class="inputer floating-label">
							<div class="input-wrapper">
								<input type="text" class="form-control" id="firstname" required>
								<label for="firstname">First Name</label>
							</div>
						</div>
						<div class="inputer floating-label">
							<div class="input-wrapper">
								<input type="email" class="form-control" id="email" required>
								<label for="email">Email Address</label>
							</div>
						</div>
						<div class="inputer floating-label">
							<div class="input-wrapper">
								<input type="password" class="form-control" id="password"
									required> <label for="password">Password</label>
							</div>
						</div>

						<div class="inputer floating-label">
							<div class="input-wrapper">
								<input type="password" class="form-control" id="confirmPassword"
									required> <label for="confirmPassword">Confirm
									Password</label>
							</div>
						</div>

						<div class="row">
							<div class="switcher switcher-green form-inline">
								<input id="userAddStatus" type="checkbox" hidden="hidden"
									checked="checked"> <label for="userAddStatus"></label>
							</div>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-flat btn-default btn-ripple"
							data-dismiss="modal">CANCEL</button>
						<button id="addUserClicked" type="button"
							class="btn btn-primary button-striped button-full-striped btn-ripple"
							data-dismiss="modal">
							SAVE<span class="ripple _3 animate"
								style="height: 96px; width: 96px; top: -28px; left: 20.9844px;"></span><span
								class="ripple _4 animate"
								style="height: 96px; width: 96px; top: -32px; left: 35.9844px;"></span>
						</button>
					</div>
				</div>
				.modal-content
			</div>
			.modal-dialog
		</div> -->
		<!--END ADD USER MODAL  -->

		<!--BEGIN ALERT DIALOG  -->
		<!-- <button ​ style="display: none" id="success-alert"
			data-toastr-notification="USER HAS BEEN SAVE SUCCESSFULLY!"
			class="btn btn-default toastr-notify btn-ripple"
			data-toastr-close-others="true"
			data-toastr-position="toast-top-full-width"
			data-toastr-type="success">
			Success<span class="ripple _30 animate"
				style="height: 148px; width: 148px; top: -56px; left: -2px;"></span><span
				class="ripple _31 animate"
				style="height: 148px; width: 148px; top: -46px; left: -16px;"></span><span
				class="ripple _32 animate"
				style="height: 148px; width: 148px; top: -58px; left: -19px;"></span><span
				class="ripple _34 animate"
				style="height: 148px; width: 148px; top: -58px; left: -44px;"></span>
		</button> -->

	</div>
	<!--.content-->

	<!--MENU NAVIGATION  -->
	<div class="layer-container">
		<jsp:include page="fragment/nav-menu.jsp"></jsp:include>
	</div>
	<!--.layer-container-->

	<!--FOOTER COMPONENTS  -->
	<jsp:include page="fragment/footer-component.jsp"></jsp:include>

	<script>
		//CKEDITOR.replace('proDescModel');
		CKEDITOR.replace('proDescModel');
	</script>

	<!--SCRIPT FOR USER PAGE  -->
	<script
		src="${pageContext.request.contextPath }/resources/admin/angular/product.js"></script>

</body>
</html>