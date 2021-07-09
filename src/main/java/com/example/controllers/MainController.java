package com.example.controllers;

import com.example.models.Message;
import com.example.models.User;
import com.example.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import static com.example.controllers.ControllerUtils.getErrors;

@Controller
public class MainController  {

    @Autowired
    private MessageRepository messageRepository;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/main")
    public String main(
            @RequestParam(required = false, defaultValue = "") String filter
            ,Map<String, Object> model){
        Iterable<Message> messageAll;
        if(filter != null && !filter.isEmpty())
            messageAll = messageRepository.findByTag(filter);
        else
            messageAll = messageRepository.findAll();
        model.put("messages", messageAll);
        model.put("filter", filter);
        return "mainPage";
    }

    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file) throws IOException {
        message.setAuthor(user);

        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = getErrors(bindingResult);
            System.out.println(errorsMap.keySet());
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        }else {
            saveFile(message, file);
            model.addAttribute("message", null);
            messageRepository.save(message);
        }
        Iterable<Message> messageAll = messageRepository.findAll();
        model.addAttribute("messages", messageAll);

        return "mainPage";
    }

    private void saveFile(@Valid Message message, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();
            String uuidFile = UUID.randomUUID().toString();
            String resultfilename = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultfilename));
            message.setFilename(resultfilename);
        }
    }


    @GetMapping("/")
    public String helloPage(@RequestParam(name="name", required = false, defaultValue = "World") String name,
                            Map<String, Object> model){
        model.put("name",name);
        return "home";
    }

    @GetMapping("/user-messages/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam(required = false) Message message,
            Model model
    ){
        model.addAttribute("userChannel", user);
        model.addAttribute("subscriptionsCount", user.getSubscribtions().size());
        model.addAttribute("subscribersCount", user.getSubscribers().size());
        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));
        model.addAttribute("messages",user.getMessages());
        model.addAttribute("message",message);
        model.addAttribute("isCurrentUser",currentUser.equals(user));

        return "userMessages";
    }

    @PostMapping("/user-messages/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("textMessage") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        if(message.getAuthor().equals(currentUser)){
            if(!StringUtils.isEmpty(text)){
                message.setTextMessage(text);
            }
            if(!StringUtils.isEmpty(tag)){
                message.setTextMessage(tag);
            }
            saveFile(message, file);
            messageRepository.save(message);
        }

        return "redirect:/user-messages/"+user;
    }

}
