import com.sis.model.PrintInfo;
import com.sis.service.ConfigService;
import com.sis.service.PrintService;
import com.sis.util.ConfigUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * Created by xp-zhao on 2017/12/14.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration ({
	"classpath:spring/spring-dao.xml",
	"classpath:spring/spring-service.xml",
	"classpath:spring/spring-web.xml"
})
public class PrintTest
{
	/*@Autowired
	private ConfigService configService;

	@Autowired
	private     PrintService  printService;

	@Test
	public void test()
	{
		// 获取配置的总量限制和每日限量
		String printCount = configService.getConfigvalue(ConfigUtil.PRINT_COUNT);
		String printCountDay = configService.getConfigvalue(ConfigUtil.PRINT_COUNT_DAY);
		System.out.println(printCount+":"+printCountDay);
		//根据学生ID查询有打印次数是否超出上限  或者  超出每日上限
		PrintInfo printInfo = new PrintInfo("2013051233","xp","1306");
//		printService.recordPrint(printInfo);
		String studentId = "2013051233";
		int userCount = printService.getAllPrintCount(studentId,"1302");
		int userCountDay = printService.getDayPrintCount(studentId);
		System.out.println(""+":"+userCountDay);
	}*/
}
