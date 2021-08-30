package my.bookshop.handlers;

import java.util.stream.Stream;
import java.util.*;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Select;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.draft.DraftService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;

import com.sap.cds.Result;
import com.sap.cds.Struct;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.services.ErrorStatuses;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.draft.DraftService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.contactservice.InsertContactsContext;
import cds.gen.contactservice.InsertPlacesContext;
import cds.gen.contactservice.AddContactsContext;
import cds.gen.contactservice.ContactService_;
import cds.gen.contactservice.Contacts;
import cds.gen.contactservice.Contacts_;
import cds.gen.contactservice.Places;
import cds.gen.contactservice.Places_;
// import my.bookshop.MessageKeys;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
// import org.springframework.beans.factory.annotation.Qualifier;
// import org.springframework.stereotype.Component;

@Component
@ServiceName(ContactService_.CDS_NAME)
public class contactservicehandler implements EventHandler {

	private final DraftService contactService;
    private final Messages messages;
    private final CqnAnalyzer analyzer;
    private final PersistenceService db;
    
    private final static Logger logger = LoggerFactory.getLogger(contactservicehandler.class);

	contactservicehandler(@Qualifier(ContactService_.CDS_NAME) DraftService contactService, Messages messages, CdsModel model, PersistenceService db) {
		this.contactService = contactService;
        this.messages = messages;
        this.analyzer = CqnAnalyzer.create(model);
        this.db=db;
	}

	@Before(event = { CqnService.EVENT_READ })
    public void beforeReadContact(Stream<Contacts> contacts) 
    {
        logger.warn("I say we are going to allow a read of this contact from our table. Congratulations.");
        if (contacts!=null)
        {
        contacts.forEach
        (
            contact->
            {
                logger.warn("{} is one, with phone {}",contact.getName(),contact.getPhone());
            }
        );
        }
		// reviews.forEach(review -> {
		// 	validateBook(review);
		// 	validateRating(review);
		// });
    }
    
    @Before(event = { CqnService.EVENT_CREATE})
    public void beforeCreatePlaces(Stream<Places> places) 
    {
        logger.warn("I say we are trying to be going to create this place into our table. Congratulations.");
        if (places!=null)
        {
        places.forEach
        (
            place->
            {
                // logger.warn("{} is one, with phone {}",contact.getName(),contact.getPhone());
                if (place.getTitle()==null || place.getTitle()=="")
                {
                    System.out.println("The place must have a name");
                    logger.error("There was an attempt to create a nameless place");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "The place must have a name")
                    .messageTarget(Contacts_.class, r -> r.name());
                    
                }
                else
                {
                    Result result = db.run(Select.from(ContactService_.PLACES)
                                            .where(c -> c.title().eq(place.getTitle())));
                    if (result.first().isPresent()) 
                    {
                        System.out.println("The place is already present in our records. Use that or please create a different one.");
                        logger.error("There was an attempt to create multiple profiles for the same place");
                        throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "The place is already present in our records. Use that or please create a different one.")
                        .messageTarget(Contacts_.class, r -> r.name());
                    }
                }
                // if (contact.getPhone()==null || contact.getPhone().length()!=10)
                // {
                //     System.out.println("We need phone numbers to be 10 digits long. Its just our policy.");
                //     logger.error("There was an attempt to ignore phone numbering policy");
                //     throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "We need phone numbers to be 10 digits long. This is just our policy.")
				// 	.messageTarget(Contacts_.class, r -> r.phone());
                // }
                // if (contact.getPlaceId()==null)
                // {
                //     System.out.println("Please please please do select a place");
                //     logger.error("There was an attempt to not select a place");
                //     throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "Please please please do select a place")
				// 	.messageTarget(Contacts_.class, r -> r.place());
                // }
            }
        );
        }
		// reviews.forEach(review -> {
		// 	validateBook(review);
		// 	validateRating(review);
		// });
    }
    
    @Before(event = { CqnService.EVENT_CREATE})
    public void beforeCreateContact(Stream<Contacts> contacts) 
    {
        logger.warn("I say we are going to create this contact into our table. Congratulations.");
        if (contacts!=null)
        {
        contacts.forEach
        (
            contact->
            {
                // logger.warn("{} is one, with phone {}",contact.getName(),contact.getPhone());
                if (contact.getName()==null || contact.getName()=="")
                {
                    System.out.println("The person must have a name");
                    logger.error("There was an attempt to create a nameless perspn");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "The person must have a name")
                    .messageTarget(Contacts_.class, r -> r.name());
                    
                }
                else
                {
                    Result result = db.run(Select.from(ContactService_.CONTACTS)
                                            .where(c -> c.name().eq(contact.getName())));
                    if (result.first().isPresent()) 
                    {
                        System.out.println("The persom is already present in our records. Use that or please create a different one.");
                        logger.error("There was an attempt to create multiple profiles for the same person");
                        throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "The person is already present in our records. Use that or please create a different one.")
                        .messageTarget(Contacts_.class, r -> r.name());
                    }
                }
                if (contact.getPhone()==null || contact.getPhone().length()!=10)
                {
                    System.out.println("We need phone numbers to be 10 digits long. Its just our policy.");
                    logger.error("There was an attempt to ignore phone numbering policy");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "We need phone numbers to be 10 digits long. This is just our policy.")
					.messageTarget(Contacts_.class, r -> r.phone());
                }
                if (contact.getPlaceId()==null)
                {
                    System.out.println("Please please please do select a place");
                    logger.error("There was an attempt to not select a place");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "Please please please do select a place")
					.messageTarget(Contacts_.class, r -> r.place());
                }
            }
        );
        }
		// reviews.forEach(review -> {
		// 	validateBook(review);
		// 	validateRating(review);
		// });
    }
    

    @Before(event = {CqnService.EVENT_UPSERT, CqnService.EVENT_UPDATE })
    public void beforeUpdateContact(Stream<Contacts> contacts) 
    {
        logger.warn("I say we are going to update this contact into our table. Congratulations.");
        if (contacts!=null)
        {
        contacts.forEach
        (
            contact->
            {
                logger.warn("{} is one, with phone {}",contact.getName(),contact.getPhone());
                
                Result result = db.run(Select.from(ContactService_.CONTACTS)
                                        .where(c -> c.name().eq(contact.getName())));
                if (result.first().isPresent()) 
                {
                    System.out.println("The name is already present in the phonebook. Please choose a different one.");
                    logger.error("There was an attempt to create multiple profiles for the same named person");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "The name is already present in the phonebook. Please choose a different one.")
                    .messageTarget(Contacts_.class, r -> r.name());
                }
                
                if (contact.getPhone()==null);
                else if (contact.getPhone().length()!=10)
                {
                    System.out.println("We need phone numbers to be 10 digits long. Its just our policy.");
                    logger.error("There was an attempt to ignore phone numbering policy");
                    throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "We need phone numbers to be 10 digits long. This is just our policy.")
					.messageTarget(Contacts_.class, r -> r.phone());
                }
                // if (contact.getPlaceId()==null)
                // {
                //     System.out.println("Please please please do select a place");
                //     throw new ServiceException(ErrorStatuses.METHOD_NOT_ALLOWED, "Please please please do select a place")
				// 	.messageTarget(Contacts_.class, r -> r.place());
                // }
            }
        );
        }
		// reviews.forEach(review -> {
		// 	validateBook(review);
		// 	validateRating(review);
		// });
    }

    @Before(entity=Contacts_.CDS_NAME)
    public void beforeButtonClick(AddContactsContext context)
    {
        System.out.println("!!!!!!!_____!!!!!!! The button has been clicked before!!!!!!!_____!!!!!!!");
        // if (context.getPlace()==null)context.setPlace("bl");
    }

    @On(entity=Contacts_.CDS_NAME)
    public void onButtonClick(AddContactsContext context)
    {
        System.out.println("!!!!!!!_____!!!!!!! The button has been clicked on!!!!!!!_____!!!!!!!");
        System.out.println("!The entered name was " + context.getName());
        System.out.println("The entered phone was " + context.getPhone());
        System.out.println("The cqn was " + context.getCqn());
        String contactId = (String) analyzer.analyze(context.getCqn()).targetKeys().get(Contacts.ID);   
        System.out.println("The contact Id was " + contactId);
        System.out.println("The context was " + context);

        Contacts con=Contacts.create();
        con.setId(contactId);
        if (context.getName().equals(""));
        else con.setName(context.getName());
        if (context.getPhone().equals(""));
        else con.setPhone(context.getPhone());
        if (context.getPlace().equals(""));
        else con.setPlaceId(context.getPlace());
        Result res = contactService.run(Update.entity(ContactService_.CONTACTS).data(con));
        // CqnUpdate update = Update.entity("ContactService_.CONTACTS").data(con);
        context.setCompleted();
    }
    
    @On(event=InsertContactsContext.CDS_NAME)//entity=Contacts_.CDS_NAME)
    public void onButton2Click(InsertContactsContext context)
    {
        System.out.println("!!!!!!!_____!!!!!!! The button 2 has been clicked on!!!!!!!_____!!!!!!!");
        System.out.println("!The entered name was " + context.getName());
        System.out.println("The entered phone was " + context.getPhone());
        // System.out.println("The cqn was " + context.getCqn());
        // String contactId = (String) analyzer.analyze(context.getCqn()).targetKeys().get(Contacts.ID);   
        // System.out.println("The contact Id was " + contactId);
        System.out.println("The context was " + context);

        Contacts con=Contacts.create();
        //con.setId(contactId);
        // if (context.getName().equals(""));
        // else 
        con.setName(context.getName());
        // if (context.getPhone().equals(""));
        // else 
        con.setPhone(context.getPhone());
        // if (context.getPlace().equals(""));
        // else 
        con.setPlaceId(context.getPlace());
        Result res = contactService.run(Insert.into(ContactService_.CONTACTS).entry(con));

        // Contacts con=Contacts.create();
        // con.setId(contactId);
        // if (context.getName().equals(""));
        // else con.setName(context.getName());
        // if (context.getPhone().equals(""));
        // else con.setPhone(context.getPhone());
        // if (context.getPlace().equals(""));
        // else con.setPlaceId(context.getPlace());
        // Result res = contactService.run(Update.entity(ContactService_.CONTACTS).data(con));
        // CqnUpdate update = Update.entity("ContactService_.CONTACTS").data(con);
        context.setCompleted();
    }
    
    
     @On(event=InsertPlacesContext.CDS_NAME)//entity=Contacts_.CDS_NAME)
    public void onButton3Click(InsertPlacesContext context)
    {
        System.out.println("!!!!!!!_____!!!!!!! The button 3 has been clicked on!!!!!!!_____!!!!!!!");
        System.out.println("!The entered name was " + context.getName());
        // System.out.println("The entered phone was " + context.getPhone());
        // System.out.println("The cqn was " + context.getCqn());
        // String contactId = (String) analyzer.analyze(context.getCqn()).targetKeys().get(Contacts.ID);   
        // System.out.println("The contact Id was " + contactId);
        System.out.println("The context was " + context);

        Places pla=Places.create();
        //con.setId(contactId);
        // if (context.getName().equals(""));
        // else 
        pla.setTitle(context.getName());
        // if (context.getPhone().equals(""));
        // else 
        //con.setPhone(context.getPhone());
        // if (context.getPlace().equals(""));
        // else 
        // con.setPlaceId(context.getPlace());
        Result res = contactService.run(Insert.into(ContactService_.PLACES).entry(pla));
        messages.success("Place successfully created");
        // Contacts con=Contacts.create();
        // con.setId(contactId);
        // if (context.getName().equals(""));
        // else con.setName(context.getName());
        // if (context.getPhone().equals(""));
        // else con.setPhone(context.getPhone());
        // if (context.getPlace().equals(""));
        // else con.setPlaceId(context.getPlace());
        // Result res = contactService.run(Update.entity(ContactService_.CONTACTS).data(con));
        // CqnUpdate update = Update.entity("ContactService_.CONTACTS").data(con);
        context.setCompleted();
    }
    

    // @Before(event = { CqnService.EVENT_CREATE, CqnService.EVENT_UPSERT, CqnService.EVENT_UPDATE })
    // public void beforeAddContact(Stream<Contacts> contacts) 
    // {
    //     logger.warn("I say we are going to insert this contact into our table. Congratulations.");
	// 	// reviews.forEach(review -> {
	// 	// 	validateBook(review);
	// 	// 	validateRating(review);
	// 	// });
	// }

	// private void validateRating(Reviews review) {
	// 	Integer rating = review.getRating();
	// 	if (rating == null || rating < 1 || rating > 5) {
	// 		messages.error(MessageKeys.REVIEW_INVALID_RATING).target("in", Reviews_.class, r -> r.rating());
	// 	}
	// }

	// private void validateBook(Reviews review) {
	// 	if(review.getBookId() == null || contactService.run(Select.from(ContactService.BOOKS).byId(review.getBookId())).rowCount() == 0) {
	// 		messages.error(MessageKeys.BOOK_MISSING).target("in", Reviews_.class, r -> r.book_ID());
	// 	}
	// }

}
