<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="card">
		<div class="card-header border-bottom">
			<h5 class="card-title mb-0">검색필터</h5>
			<div
				class="d-flex justify-content-between align-items-center row pt-4 gap-4 gap-md-0 g-6">
				<div class="col-md-6 user_plan"></div>
				<div class="col-md-6 user_status"></div>
			</div>
		</div>


		<div class="card-datatable table-responsive">
			<table class="datatables-users table border-top">
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>고객명</th>
						<th>최근결재방식</th>
						<th>기업(단체)명</th>
						<th>가입일자</th>
						<th>구매상태</th>
						<th>비고</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- Offcanvas to add new user -->
		<div class="offcanvas offcanvas-end" tabindex="-1"
			id="offcanvasAddUser" aria-labelledby="offcanvasAddUserLabel">
			<div class="offcanvas-header border-bottom">
				<h5 id="offcanvasAddUserLabel" class="offcanvas-title">Add User</h5>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body mx-0 flex-grow-0 p-6 h-100">
				<form class="add-new-user pt-0" id="addNewUserForm"
					onsubmit="return false">
					<div class="mb-6">
						<label class="form-label" for="add-user-fullname">Full
							Name</label> <input type="text" class="form-control"
							id="add-user-fullname" placeholder="John Doe" name="userFullname"
							aria-label="John Doe" />
					</div>
					<div class="mb-6">
						<label class="form-label" for="add-user-email">Email</label> <input
							type="text" id="add-user-email" class="form-control"
							placeholder="john.doe@example.com"
							aria-label="john.doe@example.com" name="userEmail" />
					</div>
					<div class="mb-6">
						<label class="form-label" for="add-user-contact">Contact</label> <input
							type="text" id="add-user-contact" class="form-control phone-mask"
							placeholder="+1 (609) 988-44-11"
							aria-label="john.doe@example.com" name="userContact" />
					</div>
					<div class="mb-6">
						<label class="form-label" for="add-user-company">Company</label> <input
							type="text" id="add-user-company" class="form-control"
							placeholder="Web Developer" aria-label="jdoe1" name="companyName" />
					</div>
					<div class="mb-6">
						<label class="form-label" for="country">Country</label> <select
							id="country" class="select2 form-select">
							<option value="">Select</option>
							<option value="Australia">Australia</option>
							<option value="Bangladesh">Bangladesh</option>
							<option value="Belarus">Belarus</option>
							<option value="Brazil">Brazil</option>
							<option value="Canada">Canada</option>
							<option value="China">China</option>
							<option value="France">France</option>
							<option value="Germany">Germany</option>
							<option value="India">India</option>
							<option value="Indonesia">Indonesia</option>
							<option value="Israel">Israel</option>
							<option value="Italy">Italy</option>
							<option value="Japan">Japan</option>
							<option value="Korea">Korea, Republic of</option>
							<option value="Mexico">Mexico</option>
							<option value="Philippines">Philippines</option>
							<option value="Russia">Russian Federation</option>
							<option value="South Africa">South Africa</option>
							<option value="Thailand">Thailand</option>
							<option value="Turkey">Turkey</option>
							<option value="Ukraine">Ukraine</option>
							<option value="United Arab Emirates">United Arab
								Emirates</option>
							<option value="United Kingdom">United Kingdom</option>
							<option value="United States">United States</option>
						</select>
					</div>
					<div class="mb-6">
						<label class="form-label" for="user-role">User Role</label> <select
							id="user-role" class="form-select">
							<option value="subscriber">Subscriber</option>
							<option value="editor">Editor</option>
							<option value="maintainer">Maintainer</option>
							<option value="author">Author</option>
							<option value="admin">Admin</option>
						</select>
					</div>
					<div class="mb-6">
						<label class="form-label" for="user-plan">Select Plan</label> <select
							id="user-plan" class="form-select">
							<option value="basic">Basic</option>
							<option value="enterprise">Enterprise</option>
							<option value="company">Company</option>
							<option value="team">Team</option>
						</select>
					</div>
					<button type="submit" class="btn btn-primary me-3 data-submit">Submit</button>
					<button type="reset" class="btn btn-label-danger"
						data-bs-dismiss="offcanvas">Cancel</button>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- Vendors JS -->
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/moment/moment.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/select2/select2.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/@form-validation/popular.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/@form-validation/bootstrap5.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/@form-validation/auto-focus.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/cleavejs/cleave.js"></script>
<script defer
	src="${cPath}/resources/webProvider/assets/vendor/libs/cleavejs/cleave-phone.js"></script>

<!-- Page JS -->
<script defer
	src="${cPath}/resources/webProvider/assets/js/web-user-list.js"></script>
