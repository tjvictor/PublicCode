--user log
with d as
(
	select distinct S_ID from dbo.tblUserScheduleLog where U_ID = @p0
)
select a.*, b.Name, c.FirstName, c.LastName from dbo.tblUserScheduleLog as a
join dbo.tblCourse as b on a.C_ID = b.ID
join dbo.tblTeacher as c on a.T_ID = c.ID
join d on a.S_ID = d.S_ID
order by UpdateTime desc

--insert schedule
insert into dbo.tblSchedule values(@p0,@p1,@p2,@p3,@p4,getdate(),1,getdate(),@p5,@p6),
new string[]{"@p0","@p1","@p2","@p3","@p4","@p5","@p6"},
new object[]{}

insert into dbo.tblUserScheduleLog
	select newid(),@p1 = U_ID,a.* from tblSchedule as a where a.ID = @p0

--update schedule
update tblSchedule set C_ID = @p1, T_ID = @p2, C_StartTime = @p3, C_EndTime = @p4, 
Status = @p5, UpdateTime = getdate(), TaobaoLink = @p6, TaobaoTradeNo = @p7
where ID = @p0;
new string[]{"@p0","@p1","@p2","@p3","@p4","@p5","@p6","@p7"},
new object[]{}

insert into dbo.tblUserScheduleLog
	select newid(),U_ID,a.* from tblSchedule where a.ID = @p0

--delete schedule
insert into dbo.tblUserScheduleLog
	select newid(),@p1 = U_ID,a.ID, a.C_ID, a.T_ID, a.C_StartTime, a.C_EndTime,
	a.CreateTime, 0, getdate(), a.TaobaoLink from tblSchedule as a where a.ID = @p0
	
delete from tblSchedule where ID = @p0;

--Cancel schedule
Deleted = 0,
Free,
Book,
Cancel,
Deal,
Done,
update tblSchedule set Status = 3, UpdateTime = getdate()
where ID = @p0;
new string[]{"@p0"},
new object[]{}

insert into dbo.tblUserScheduleLog
	select newid(),@p1 = U_ID,a.* from tblSchedule as a where a.ID = @p0

insert into dbo.tblSchedule values(@p0,@p1,@p2,@p3,@p4,getdate(),1,getdate(),@p5,@p6),
new string[]{"@p0","@p1","@p2","@p3","@p4","@p5","@p6"},
new object[]{}
--GUID.Empty: system auto-generate
insert into dbo.tblUserScheduleLog
	select newid(),@p1 = GUID.Empty, * from tblSchedule as a where a.ID = @p0
	
