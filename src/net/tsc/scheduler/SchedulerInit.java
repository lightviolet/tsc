package net.tsc.scheduler;

import java.text.ParseException;

import javax.servlet.http.HttpServlet;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;
  
public class SchedulerInit extends HttpServlet{  
  private SchedulerFactory schedFact;  
  private Scheduler sched;  
  
  public SchedulerInit() {  
    try {  
      schedFact = new StdSchedulerFactory();  
      sched = schedFact.getScheduler();  
      sched.start(); 
       //"job이름, 그룹명, 동작시킬Class"  
      JobDetail job1 = new JobDetail("Job_TscUpdate", "group1", JobSendInfoUpdate.class);   
       // 매분 0초에 동작(30초마다 동작시키려면 job을 하나더 만들고 아래에 0대신 30을 넣으면 ok  
      CronTrigger trigger1 = new CronTrigger("Trigger_TscUpdate", "group1", "0/30 * * * * ?");   
      sched.scheduleJob(job1, trigger1);  
       
    } catch (SchedulerException e) {  
      e.printStackTrace();  
    } catch (ParseException e) {  
      e.printStackTrace();  
    }  
  }  
  
  public static void main(String[] args) {  
    new SchedulerInit();  
  }  
}  