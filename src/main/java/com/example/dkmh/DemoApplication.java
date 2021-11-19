package com.example.dkmh;

import com.example.dkmh.entity.Subjects;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

@SpringBootApplication
@EnableCaching
public class DemoApplication {

	@Bean
	public RedisTemplate<Long, Subjects> redisTemplate(RedisConnectionFactory connectionFactory) {
		RedisTemplate<Long, Subjects> template = new RedisTemplate<>();
		template.setConnectionFactory(connectionFactory);
		// Add some specific configuration here. Key serializers, etc.
		return template;
	}

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
