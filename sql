--user log
select a.*, b.Name, c.FirstName, c.LastName from dbo.tblUserScheduleLog as a
join dbo.tblCourse as b on a.C_ID = b.ID
join dbo.tblTeacher as c on a.T_ID = c.ID
where U_ID = @p0 
order by UpdateTime desc;
go

