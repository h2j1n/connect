<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 3. Detail Section (start) : 내용이 작성되는 영역입니다. -->
<table class="table">
    <colgroup>
        <col>
        <col>
        <col>
        <col>
        <col>
    </colgroup>
    <tbody>
        <tr>
            <th rowspan="2">인적사항</th>
            <th>성 명</th>
            <td><input class="form-control bg-white" type="text"></td>
            <th>주민등록번호</th>
            <td><input class="form-control bg-white" type="text"></td>
        </tr>
        <tr>
            <th>주 소</th>
            <td colspan="3"><input class="form-control bg-white" type="text"></td>
        </tr>
        <tr>
            <th rowspan="3">재직사항</th>
            <th>소 속</th>
            <td colspan="3"><input class="form-control bg-white" type="text"></td>
        </tr>
        <tr>
            <th>직 위</th>
            <td colspan="3"><input class="form-control bg-white" type="text"></td>
        </tr>
        <tr>
            <th>재직기간</th>
            <td colspan="3">
                <input class="form-control bg-white" type="text"> ~ 
                <input class="form-control bg-white" type="text">
            </td>
        </tr>
        <tr>
            <th>발급용도</th>
            <td colspan="4"><input class="form-control bg-white" type="text"></td>
        </tr>
        <tr>
            <td colspan="5">
                위와 같이 재직하고 있음을 증명합니다. 
                20<input class="form-control bg-white" type="text">년
                <input class="form-control bg-white" type="text">월
                <input class="form-control bg-white" type="text">일
            </td>
        </tr>
    </tbody>
</table>
<!-- 3. Detail Section (end) -->
