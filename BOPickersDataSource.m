//
//  BOPickersDataSource.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "BOPickersDataSource.h"


@implementation BOPickersDataSource

@synthesize customPickerArray;

- (id)init
{
	// use predetermined frame size
	self = [super init];
	if (self)
	{
		// create the data source for this custom picker
		
	
	}
	return self;
}



-(void)setupCustomPickerArrayWithPropertyName:(NSString *)propertyNameValue

{
 

    
    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    
    if ([propertyNameValue isEqualToString:@"build"]) {
       [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                       @"emaciated", 
                                       @"sickley",@"malnourished", @"undernourished", @"very thin",@"thin", @"lean", @"wiry", @"slender", @"lanky", @"skinny",@"bony",@"petite",@"small-boned",@"average", @"weight proportionate to height", @"well nourished", @"healthy", @"large-boned", @"large-framed", @"stocky", @"chubby", @"heavy-set",@"heavy", @"formidable size", @"very large",@"enourmous",@"large round belly",   
                                       nil]];
        self.customPickerArray=viewArray;
        return;
    }
    if ([propertyNameValue isEqualToString:@"complexion"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal/healthy",@"fair", 
                                       @"tanned", @"sunburned", @"jaundiced", @"sickly", @"pale", @"pallid",@"leathery",@"pimply",@"warty", @"shows negligect", @"mild scaring",@"heavy scaring" , @"numerous birthmarks",@"numerous moles", @"wringles",  
                                        nil]];
        self.customPickerArray=viewArray;
        return;
    }

    if ([propertyNameValue isEqualToString:@"face"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"age appropriate",@"normal",@"appeared younger for age", 
                                        @"old-looking for true age",@"baby-faced", @"long-faced", @"odd shaped",   
                                        nil]];
        self.customPickerArray=viewArray;
        return;
    }

    
    if ([propertyNameValue isEqualToString:@"facialExpressions"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"attentive",@"alert",@"focused", 
                                        @"intense look",@"interested",@"confident", @"tense", @"fierce", @"worried",@"indrawn",@"frightened", 
                                        @"dazed",@"alarmed", @"terrified",@"sad", @"frowning", @"downcast", @"unsmiling", @"grimacing", @"forlorn",@"hopeless",@"slightly tearful",@"heavy tears",   @"sobbing",@"loud sobbing",@"moaning", @"apathetic", @"preoccupied",@"inattentive" , @"withdrawn", @"vacuous",@"vacant", @"detached", @"flat",@"mask-like",@"blank",   @"lacked spontaneous expression", @"expressionless", @"stiff",   @"frozen", @"rigid",@"calm",@"composed",@"relaxed",@"dreamy", @"sleepy", @"tired", @"smiling", @"cheerful", @"happy", @"delighted", @"silly grin", @"grinning", @"beaming",@"bright",@"unhappy",   @"angry", @"distrustful",@"disgusted",  @"contempt", @"defiant", @"snearing", @"scallowing", @"grim",@"dour",@"tight-lipped", @"sour", @"smug",
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }

    if ([propertyNameValue isEqualToString:@"eyes"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal", @"unremarkable",   @"large",@"small",@"close-set", 
                                        @"wide-set",@"almond-shapped", @"sunken", @"bloodshot",@"reddened",@"glassy", @"foggy",  
                                        @"bulging",@"hooded",@"sagging", @"puffy",   @"wide-eyed", @"cross-eyed", @"wall-eyed", @"disconjugate gaze", @"bright",@"staring", @"unblinking", @"glassy-eyed",@"vacant",@"penetrating",   @"piercing",@"vigilant",@"nervous", @"frequent blinking", @"unblinking",@"Mydriasis",@"fixed", @"constricted pupils",@"darting",@"squinting" , @"tired", @"twinkling",@"limpid", @"unusual", @"blank",@"dialated", @"unusual", @"beeting brows", @"heavy", @"raised", @"pulled together",@"pulled down",@"shaven",@"plucked",@"regular glasses", @"stylish glasses",@"half lenses", @"bifocals", @"reading glasses", @"contact lenses", @"colored contacts",   @"sunglasses", @"squinting", @"winking",@"broken glasses",@"large framed glasses",  
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    if ([propertyNameValue isEqualToString:@"eyeContact"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal for culture", @"unremarkable",   @"avoided", @"evasive",@"intrusive",@"downcast",@"passing", 
                                        @"humerous", @"wry", @"conceited",@"condescending",@"angry",   @"casual",@"engaged", @"seductive",  
                                        @"serene",  
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    if ([propertyNameValue isEqualToString:@"hair"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"fashionable style",@"long", @"short",@"ponytail", 
                                        @"pigtails",@"plaits", @"cornrows", @"braided",@"crew cut",@"natural afro", 
                                        @"frizzy",@"curly", @"finger curls", @"dreadlocks", @"wavy", @"straight", @"uncombed", @"tousled", @"punk",@"Mohwk",@"mullet",   @"shaven",@"currently popular",@"stylish", @"unusal hair cut", @"uneven",@"slicked back" , @"shiny", @"moussed",@"permed", @"relaxed", @"unbarbered",@"simple", @"short", @"page boy", @"fade", @"unremarkable", @"bleached",@"color dyed",@"frosted",@"streaks of color",@"different colored roots", @"flecked with gray", @"salt-and-pepper", @"gray", @"white", @"faded color", @"albino", @"platinum blonde", @"red", @"auburn",@"brunette",  @"brown", @"black", @"raven", @"fine-haird", @"bald", @"receding hairline", @"balding",@"high forehead", @"male-pattern baldness", @"bald spot", @"shaved head",@"alopecia", @"wig",@"toupee", @"hairpiece", @"implants", @"transplants", @"an obvious hairpiece", @"clean", @"dirty", @"unkempt", @"greasy/oily", @"matted",           
                                        nil]];
        
       
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    if ([propertyNameValue isEqualToString:@"beard"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"clean-shaven",@"unshaven", 
                                        @"several days' growth",@"wispy", @"scraggly", @"stubble",@"poorly maintained",@"well maintained", 
                                        @"stylish",@"neatly trimmed", @"full", @"closely trimmed", @"mutton chopps", @"goatee", @"chin beard", @"unbarbered", @"Van Dyke",@"Santa Clause Style",@"well maintained moustache",   @"handlebars",@"thin moustached",@"colonel", @"neat", @"scraggly",@"dirty" ,@"food in beard",           
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    if ([propertyNameValue isEqualToString:@"hygiene"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"appropriate",@"excellent", 
                                        @"unremarkable",@"fair", @"marginal", @"poor",@"scruffy",@"neglected", 
                                        @"neat",@"tidy", @"meticulous", @"musty odor", @"noticable odor", @"offensive odor", @"strong odor",   @"excess cologne", @"excess perfume", @"smells of alcohol",@"smells of tobacco",@"tobacco stained fingers", @"several missing teeth", @"toothless", @"poor oral hygiene", @"good oral hygiene", @"dendutres", @"dental jewlery",@"braces",                    
                                        nil]];
        self.customPickerArray=viewArray;
        return;
    }
    if ([propertyNameValue isEqualToString:@"skin"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"clean and normal",@"fair", @"light skinned", @"dark skinned", @"very dark skinned",    
                                        @"dirty",@"bruises", @"cuts", @"abrasions",@"scabs",@"sores", 
                                        @"mild psoriasis",@"heavy psoriasis", @"acne", @"acne vulgaris scars",@"a few visible tatoos", @"many visible tatoos",          
                                        nil]];
        self.customPickerArray=viewArray;
        return;
    }
    
    if ([propertyNameValue isEqualToString:@"dress"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"appropriate for situation",@"presentable", 
                                        @"professional appearance",@"modestly attired", @"more suitable for younger",@"not suitable for age", @"overly casual", @"dressed to impress",   @"gym clothes", @"suggestable", @"attention seeking", @"outlandish", @"bizarre", @"filthy", @"grimy", @"dirty", @"smelly", @"dusty", @"musty", @"food-spotted", @"oily", @"rumpled", @"disheveled", @"neglected", @"wrong size", @"ill-fitted", @"unkempt", @"messy", @"slovenly",@"sloppy",@"baggy", @"bedraggled", @"raggedy", @"needing repair", @"threadbare", @"seedy", @"clean but worn", @"worn", @"shabby", @"tattered", @"torn", @"shows", @"unilateral neglect", @"unzipped", @"unbuttoned", @"plain",@"out of date", @"old-fashioned", @"regional", @"eccentric", @"grunge", @"prim", @"somber", @"all black", @"neat", @"careful dresser", @"overdressed", @"seductive", @"revealing", @"flashy", @"too tight-fitting", @"tasteless design", @"visible undergarments",@"swimming clothes", @"dress clothes", @"not wearing clothes", @"buttocks visible", @"breasts visible", @"not wearing shoes", @"not wearing shirt", @"tank top",@"undershirt as outerwear", @"bracelets", @"necklaces", @"cap", @"hat", @"cowboy hat", @"work boots", @"sneakers", @"slippers", @"flip-flops", @"sandals", @"high heeled shoes",@"dress shoes", @"t-shirt", @"jacket", @"vest", @"leather jacket", @"motorcycle gear", @"military boots", @"military uniform", @"medical clothes", @"work uniform",                                                    
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    
    if ([propertyNameValue isEqualToString:@"otherBehaviors"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"fidgety",@"restless", 
                                        @"inappropriate laughter",@"inappropriate smiling", @"incongruent laughter",@"incongruent smiling", @"giggling", @"biting fingernails",   @"twittling fingers", @"odd noises", @"tapping", @"shaking", @"constant movement", @"audible sighs", @"hand wringing", @"frequent audible gas", @"deficating", @"urinating", @"bouncing", @"jumping", @"twirling", @"head banging", @"biting self", @"biting others", @"restrained", @"screaming", @"ignoring", @"masterbating", @"exercising",@"acrobatic movements",@"akathisia", @"akinesia", @"akinetic mutism", @"astasia abasia", @"ataxia", @"atonia", @"bradykinesia", @"cataplexy", @"catalepsy", @"catatonic excitement", @"catatonic posturing", @"catatonic rigidity", @"chorea", @"coprolalia", @"coprophagia", @"floccillation",@"tremors", @"twirling", @"waxy flexability",                                
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }
    if ([propertyNameValue isEqualToString:@"affect"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"appropriate for situation",@"presentable", 
                                        @"professional appearance",@"modestly attired", @"more suitable for younger",@"not suitable for age", @"overly casual", @"dressed to impress",   @"gym clothes", @"suggestable", @"attention seeking", @"outlandish", @"bizarre", @"filthy", @"grimy", @"dirty", @"smelly", @"dusty", @"musty", @"food-spotted", @"oily", @"rumpled", @"disheveled", @"neglected", @"wrong size", @"ill-fitted", @"unkempt", @"messy", @"slovenly",@"sloppy",@"baggy", @"bedraggled", @"raggedy", @"needing repair", @"threadbare", @"seedy", @"clean but worn", @"worn", @"shabby", @"tattered", @"torn", @"shows", @"unilateral neglect", @"unzipped", @"unbuttoned", @"plain",@"out of date", @"old-fashioned", @"regional", @"eccentric", @"grunge", @"prim", @"somber", @"all black", @"neat", @"careful dresser", @"overdressed", @"seductive", @"revealing", @"flashy", @"too tight-fitting", @"tasteless design", @"visible undergarments",@"swimming clothes", @"dress clothes", @"not wearing clothes", @"buttocks visible", @"breasts visible", @"not wearing shoes", @"not wearing shirt", @"tank top",@"undershirt as outerwear",                                
                                        nil]];
        self.customPickerArray=[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        return;
    }

}

-(NSArray *)bODataAppearanceWithPropertyName:(NSString *)propertyNameValue

{


    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    
    if ([propertyNameValue isEqualToString:@"build"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"emaciated", 
                                        @"sickley",@"malnourished", @"undernourished", @"very thin",@"thin", @"lean", @"wiry", @"slender", @"lanky", @"skinny",@"bony",@"petite",@"small-boned",@"average", @"weight proportionate to height", @"well nourished", @"healthy", @"large-boned", @"large-framed", @"stocky", @"chubby", @"heavy-set",@"heavy", @"formidable size", @"very large",@"enourmous",@"large round belly",   
                                        nil]];
     
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"complexion"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal/healthy",@"fair", 
                                        @"tanned", @"sunburned", @"jaundiced", @"sickly", @"pale", @"pallid",@"leathery",@"pimply",@"warty", @"shows negligect", @"mild scaring",@"heavy scaring" , @"numerous birthmarks",@"numerous moles", @"wringles",  
                                        nil]];
        
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    if ([propertyNameValue isEqualToString:@"faceAgeAppeearnce"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"age appropriate",@"normal",@"appeared younger for age", 
                                        @"old-looking for true age",@"baby-faced", @"long-faced", @"odd shaped",   
                                        nil]];
       
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    
    if ([propertyNameValue isEqualToString:@"facialExpressions"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"attentive",@"alert",@"focused", 
                                        @"intense look",@"interested",@"confident", @"tense", @"fierce", @"worried",@"indrawn",@"frightened", 
                                        @"dazed",@"alarmed", @"terrified",@"sad", @"frowning", @"downcast", @"unsmiling", @"grimacing", @"forlorn",@"hopeless",@"slightly tearful",@"heavy tears",   @"sobbing",@"loud sobbing",@"moaning", @"apathetic", @"preoccupied",@"inattentive" , @"withdrawn", @"vacuous",@"vacant", @"detached", @"flat",@"mask-like",@"blank",   @"lacked spontaneous expression", @"expressionless", @"stiff",   @"frozen", @"rigid",@"calm",@"composed",@"relaxed",@"dreamy", @"sleepy", @"tired", @"smiling", @"cheerful", @"happy", @"delighted", @"silly grin", @"grinning", @"beaming",@"bright",@"unhappy",   @"angry", @"distrustful",@"disgusted",  @"contempt", @"defiant", @"snearing", @"scallowing", @"grim",@"dour",@"tight-lipped", @"sour", @"smug",
                                        nil]];
        
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    if ([propertyNameValue isEqualToString:@"eyes"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal", @"unremarkable",   @"large",@"small",@"close-set", 
                                        @"wide-set",@"almond-shapped", @"sunken", @"bloodshot",@"reddened",@"glassy", @"foggy",  
                                        @"bulging",@"hooded",@"sagging", @"puffy",   @"wide-eyed", @"cross-eyed", @"wall-eyed", @"disconjugate gaze", @"bright",@"staring", @"unblinking", @"glassy-eyed",@"vacant",@"penetrating",   @"piercing",@"vigilant",@"nervous", @"frequent blinking", @"unblinking",@"Mydriasis",@"fixed", @"constricted pupils",@"darting",@"squinting" , @"tired", @"twinkling",@"limpid", @"unusual", @"blank",@"dialated", @"unusual", @"beeting brows", @"heavy", @"raised", @"pulled together",@"pulled down",@"shaven",@"plucked",@"regular glasses", @"stylish glasses",@"half lenses", @"bifocals", @"reading glasses", @"contact lenses", @"colored contacts",   @"sunglasses", @"squinting", @"winking",@"broken glasses",@"large framed glasses",  
                                        nil]];
       
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"eyeContact"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"normal for culture", @"unremarkable",   @"avoided", @"evasive",@"intrusive",@"downcast",@"passing", 
                                        @"humerous", @"wry", @"conceited",@"condescending",@"angry",   @"casual",@"engaged", @"seductive",  
                                        @"serene",  
                                        nil]];
       
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"hair"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"fashionable style",@"long", @"short",@"ponytail", 
                                        @"pigtails",@"plaits", @"cornrows", @"braided",@"crew cut",@"natural afro", 
                                        @"frizzy",@"curly", @"finger curls", @"dreadlocks", @"wavy", @"straight", @"uncombed", @"tousled", @"punk",@"Mohwk",@"mullet",   @"shaven",@"currently popular",@"stylish", @"unusal hair cut", @"uneven",@"slicked back" , @"shiny", @"moussed",@"permed", @"relaxed", @"unbarbered",@"simple", @"short", @"page boy", @"fade", @"unremarkable", @"bleached",@"color dyed",@"frosted",@"streaks of color",@"different colored roots", @"flecked with gray", @"salt-and-pepper", @"gray", @"white", @"faded color", @"albino", @"platinum blonde", @"red", @"auburn",@"brunette",  @"brown", @"black", @"raven", @"fine-haird", @"bald", @"receding hairline", @"balding",@"high forehead", @"male-pattern baldness", @"bald spot", @"shaved head",@"alopecia", @"wig",@"toupee", @"hairpiece", @"implants", @"transplants", @"an obvious hairpiece", @"clean", @"dirty", @"unkempt", @"greasy/oily", @"matted",           
                                        nil]];
        
        
        
        return  [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"beard"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"clean-shaven",@"unshaven", 
                                        @"several days' growth",@"wispy", @"scraggly", @"stubble",@"poorly maintained",@"well maintained", 
                                        @"stylish",@"neatly trimmed", @"full", @"closely trimmed", @"mutton chopps", @"goatee", @"chin beard", @"unbarbered", @"Van Dyke",@"Santa Clause Style",@"well maintained moustache",   @"handlebars",@"thin moustached",@"colonel", @"neat", @"scraggly",@"dirty" ,@"food in beard",           
                                        nil]];
     
        return  [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"hygiene"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"appropriate",@"excellent", 
                                        @"unremarkable",@"fair", @"marginal", @"poor",@"scruffy",@"neglected", 
                                        @"neat",@"tidy", @"meticulous", @"musty odor", @"noticable odor", @"offensive odor", @"strong odor",   @"excess cologne", @"excess perfume", @"smells of alcohol",@"smells of tobacco",@"tobacco stained fingers", @"several missing teeth", @"toothless", @"poor oral hygiene", @"good oral hygiene", @"dendutres", @"dental jewlery",@"braces",                    
                                        nil]];
    
        return  [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"skin"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"clean and normal",@"fair", @"light skinned", @"dark skinned", @"very dark skinned",    
                                        @"dirty",@"bruises", @"cuts", @"abrasions",@"scabs",@"sores", 
                                        @"mild psoriasis",@"heavy psoriasis", @"acne", @"acne vulgaris scars",@"a few visible tatoos", @"many visible tatoos",          
                                        nil]];
    
        return  [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    if ([propertyNameValue isEqualToString:@"dress"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"appropriate for situation",@"presentable", 
                                        @"professional appearance",@"modestly attired", @"more suitable for younger",@"not suitable for age", @"overly casual", @"dressed to impress",   @"gym clothes", @"suggestable", @"attention seeking", @"outlandish", @"bizarre", @"filthy", @"grimy", @"dirty", @"smelly", @"dusty", @"musty", @"food-spotted", @"oily", @"rumpled", @"disheveled", @"neglected", @"wrong size", @"ill-fitted", @"unkempt", @"messy", @"slovenly",@"sloppy",@"baggy", @"bedraggled", @"raggedy", @"needing repair", @"threadbare", @"seedy", @"clean but worn", @"worn", @"shabby", @"tattered", @"torn", @"shows", @"unilateral neglect", @"unzipped", @"unbuttoned", @"plain",@"out of date", @"old-fashioned", @"regional", @"eccentric", @"grunge", @"prim", @"somber", @"all black", @"neat", @"careful dresser", @"overdressed", @"seductive", @"revealing", @"flashy", @"too tight-fitting", @"tasteless design", @"visible undergarments",@"swimming clothes", @"dress clothes", @"not wearing clothes", @"buttocks visible", @"breasts visible", @"not wearing shoes", @"not wearing shirt", @"tank top",@"undershirt as outerwear", @"bracelets", @"necklaces", @"cap", @"hat", @"cowboy hat", @"work boots", @"sneakers", @"slippers", @"flip-flops", @"sandals", @"high heeled shoes",@"dress shoes", @"t-shirt", @"jacket", @"vest", @"leather jacket", @"motorcycle gear", @"military boots", @"military uniform", @"medical clothes", @"work uniform",                                                    
                                        nil]];
       
        return  [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    } 
    
    if ([propertyNameValue isEqualToString:@"otherBehaviors"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"fidgety",@"restless", 
                                        @"inappropriate laughter",@"inappropriate smiling", @"incongruent laughter",@"incongruent smiling", @"giggling", @"biting fingernails",   @"twittling fingers", @"odd noises", @"tapping", @"shaking", @"constant movement", @"audible sighs", @"hand wringing", @"frequent audible gas", @"deficating", @"urinating", @"bouncing", @"jumping", @"twirling", @"head banging", @"biting self", @"biting others", @"restrained", @"screaming", @"ignoring", @"masterbating", @"exercising",@"acrobatic movements",@"akathisia", @"akinesia", @"akinetic mutism", @"astasia abasia", @"ataxia", @"atonia", @"bradykinesia", @"cataplexy", @"catalepsy", @"catatonic excitement", @"catatonic posturing", @"catatonic rigidity", @"chorea", @"coprolalia", @"coprophagia", @"floccillation",@"tremors", @"twirling", @"waxy flexability",                                
                                        nil]];
        
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
   


    return viewArray;

}


-(NSArray *)bOMovementsDataWithPropertyName:(NSString *)propertyNameValue{

    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    
    if ([propertyNameValue isEqualToString:@"stereotypedMovements"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"Twirling", @"rocking", @"self-stimulation", @"hand flapping", @"head slapping",@"aimless movements",@"repetitions movements" @"counterproductive movements", @"head bobbing", @"wriggling", @"hand or finger movements", @"bounces leg", @"posturing", @"picks/pulls at clothing",   
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }


    if ([propertyNameValue isEqualToString:@"mouthMovements"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"tounge chewing", @"lip smacking", @"whistling", @"made grunting sounds", @"belching", @"pulls lips into mouth",@"spits",@"swishes saliva in mouth",  
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    if ([propertyNameValue isEqualToString:@"symptomaticMovements"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"Waxy flexibility (cerea flexibilitas)", @"tardive dyskinesia", @"dysdiadochokinesia", @"Parkinsonian ExtraPyramidal Symptoms", @"athetosis", @"akathisia", @"ataxia", @"choreiform", @"akinesia", @"“pill rolling,” chewing", @"restless leg", @" opened and closed legs repeatedly", @"paced", @"restlessness", @"hyper/hypotonic", @"hyper/hypokinetic", @"echopraxia", @"cataplexy", @"denudative behavior",  
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"tremors"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"none" @"mild tremor", @"resting Tremor", @"intentional tremor"  ,@"hovering", @"quivers", @"shivers", @"twitches", @"tics", @"shakes", @"Autonomic hyperactivity",  
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"mobility"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"Confined to bed", @"uses wheelchair/adaptive equipment", @"requires suppot/assistance supervision", @"uses a gait aid cane", @"leg/back brace", @"walker", @"crutches", @"walks slow", @"walks carefully", @"difficulty standing up", @"scooter", 
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"gait"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"Astasia", @"abasia", @"ataxic", @"steppage", @"waddling", @"awry", @"shuffles", @"desultory", @"effortful", @"dilator", @"stiff", @"limps", @"drags/favors one leg", @"awkward", @"walks with slight posturing", @"lumbering", @"leans", @"rolling", @"lurching", @"collides with objects/persons", @"broad-based", @"knock-kneed", @"bowlegged", @"normal", @"ambled", @"no abnormaily of gait or station", @"fully mobile (including stairs)", @"springy", @"graceful", @"glides", @"brisk/energetic", @"limber.  Mincing", @"exaggerated", @"strides", @"dramatic", @"thespian", @"unusual",  @"bounces", @"drags feet", @"trips over self",@"walks too fast",
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    

    if ([propertyNameValue isEqualToString:@"balance"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"Dizzy", @"vertigo", @"staggers", @"sways", @"fearful of falling", @"unsteady", @"positive Romberg sign", @"complains of light-headedness", @"normal", @"no danger of falling", @"steady",
                                        nil]];
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }


    return viewArray;

}

-(NSArray *)bOSpeechDataWithPropertyName:(NSString *)propertyNameValue{


    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    
    
    
    if ([propertyNameValue isEqualToString:@"rate"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                       @"halting",  @"hesitant",  @"delayed",  @"inhibited",  @"blocked",  @"lags",  @"slowed reaction time",  @"mute",  @"selective mutism",  @"only nods",  @"unresponsive",  @"word-finding difficulties",  @"word searching",  @"difficulty generating responses",  @"slowed",  @"minimal response",  @"unspontaneous",  @"reticent",  @"terse",  @"sluggish",  @"paucity",  @"sparse",  @"impoverished",  @"laconic",  @"economical",  @"taciturn",  @"single-word answers",  @"normal",  @"initiates",  @"alert",  @"productive",  @"animated",  @"talkative",  @"fluent",  @"well spoken",  @"easy",  @"spontaneous",  @"smooth",  @"chatty",  @"even",  @"pressured",  @"loquacious",  @"garrulous",  @"excessively wordy",  @"hurried",  @"voluble",  @"expansive",  @"blurts out",  @"run-together",  @"raucous",  @"rapid",  @"fast",  @"rushed",  @"verbose",  @"overproductive",  @"long-winded",  @"bombastic",  @"nonstop",  @"vociferous",  @"overabundant",  @"copious",  @"overresponsive",  @"excessive detail",  @"voluminous",  @"hyperverbal",  @"flight of ideas",   
                                        nil]];
            return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

       

   
    
    if ([propertyNameValue isEqualToString:@"manner"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"distant", 
                                        @"hurried",@"pedantic", @"somber", @"inarticulate",@"thin", @"whiny", @"expressionless", @"mechanical", @"dramatic", @"naïve",@"normal",@"responsive",@"swell modulated",@"articulate", @"able to communicate ideas well", @"good-natured", @"engaging", @"well spoken", @"eloquent", @"realistic", @"measured", @"thoughtful",@"candid", @"open", @"frank",@"guiless",@"spoke freely", @"untroubled", @"spoke easily",@"warm",@"sincere",@"self-disclosing",@"empathic", @"emotive", @"touching", @"insightful", @"charming", @"witty", @"jovial", @"upbeat",@"clear", @"under controll",    
                                        nil]];
       
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    if ([propertyNameValue isEqualToString:@"tone"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                       @"Loud/noisy", @"almost screaming", @"strident", @"brassy", @"harsh", @"gravelly", @"hoarse", @"raspy", @"throaty", @"nasally", @"screechy", @"squeaky", @"shrill", @"staccato", @"mellifluous", @"quiet", @"soft", @"weak", @"frail", @"thin", @"“small” voice", @"barely audible",  @"whispered", @"aphonic", @"affected", @"tremulous", @"quivery", @"low-pitched", @"high-pitched", @"sing song", @"whiny", @"odd inflection", @"odd intonation", @"monotonous pitch", @"monotone", @"sad tone of voice", @"muffled",  @"bass (deep)",  @" bellowing (loud)",  @"booming (deep and loud)",  @"breathy",  @"husky",  @"childlike",  @"cracking (adolescent/pubescent)",  @"croaking (rough coarse voice)",  @"cultured",  @"deep (low)",  @"drawling",  @"droning",  @"boring",  @"monotone",  @"dulcet",  @"Sweet to the ear",  @"melodious",  @"harmonious",  @"falsetto",   @"grating",  @"gutteral",  @" harsh",  @"coarse",  @"grating",  @"hoarse",  @"grainy  hollow",  @"husky",  @"deep",  @"breathy",  @" inflectionless",  @"without accent",  @"lilting",  @"with constantly changing tone",   @"with never changing tone",  @"nasal",  @"ponticello",  @"powerful",  @"clear",  @"loud",  @"carrying",  @"purring",  @"  quavering",  @"rasping",  @"almost a whisper",  @" resonant",  @"carrying",  @"vibrating",  @"scabrous",  @"harsh",  @"musical",  @"shrill", @"high-pitched",  @"harsh",  @"sonorous",  @"soothing",  @"low",  @"calming",  @"smooth",  @"spluttering",  @"stumbling over the words",  @"often spitting",  @"squawking",  @" squeaky",  @"thin",  @" throaty",  @"shaking",  @"quavering",  @"velvety",  @"wheezing",  @"whining" ,
                                        nil]];
      
        return[viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

    if ([propertyNameValue isEqualToString:@"articulation"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"unintelligible", 
                                        @"stammer",@"stutter", @"stumbles over words", @"mumbles",@"whispers to self", @"mutters under breath", @"lisp", @"sibilance", @"slurred", @"juicy",@"garbled",@"understandable",@"clear",@"precise", @"clipped", @"choppy", @"mechanical", @"poor diction", @"poor enunciation", @"misarticulated", @"unclear", @"dysfluencies", @"spastic dysarthria",@"flaccid dysarthria", @"ataxic dysarthria", @"mixed dysarthria",@"hyperkinetic dysarthria",@"hypokinetic dysarthria", @"aphasias",    
                                        nil]];
     
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

    return viewArray;  
    

}
-(NSArray *)presentationDataWithPropertyName:(NSString *)propertyNameValue{

NSMutableArray *viewArray = [[NSMutableArray alloc] initWithObjects:@"", nil];

    if ([propertyNameValue isEqualToString:@"vision"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"good/normal", 
                                        @"Mildly Nearsighted",@"Moderately Nearsighted", @"Very Nearsighted", @"Mildly Farsighted",@"Moderately Farsighted", @"Very Farsighted", @"Reading Glasses", @"Astigmatism", @"Legally Blind Corrected",@"Color Blind ",@"Completely Blind",    
                                        nil]];
        
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

    if ([propertyNameValue isEqualToString:@"sleepQuality"]) {
        [viewArray addObjectsFromArray:[NSArray arrayWithObjects:
                                        @"good/normal", 
                                        @"difficulty falling asleep",@"Difficulty Staying Asleep", @"Early Morning Awakening", @"Frequent Napping",@"Undesired Schedule", @"Sleeps Too Much", @"Sleepy While Awake", @"Difficulty Waking Up", @"\"Sleeop Attacks\"",    
                                        nil]];
        
        return [viewArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return viewArray;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

// tell the picker which view to use for a given component and row, we have an array of views to show
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
	return [customPickerArray objectAtIndex:row];
}
#pragma mark -
#pragma mark UIPickerViewDataSource methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [customPickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


@end