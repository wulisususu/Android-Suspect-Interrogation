.class public Lcom/alibaba/sdk/android/push/notification/PushData;
.super Ljava/lang/Object;


# static fields
.field public static final KEY_BIG_BODY:Ljava/lang/String; = "big_body"

.field public static final KEY_BIG_PICTURE:Ljava/lang/String; = "big_picture"

.field public static final KEY_BIG_TITLE:Ljava/lang/String; = "big_title"

.field public static final KEY_CHANNEL:Ljava/lang/String; = "notification_channel"

.field public static final KEY_CONTENT:Ljava/lang/String; = "content"

.field public static final KEY_CUSTOM_NOTIFICAITON_ID:Ljava/lang/String; = "custom_notification_id"

.field public static final KEY_EXT:Ljava/lang/String; = "ext"

.field public static final KEY_IMAGE:Ljava/lang/String; = "image"

.field public static final KEY_INBOX_CONTENT:Ljava/lang/String; = "inbox_content"

.field public static final KEY_MSG_ID:Ljava/lang/String; = "msg_id"

.field public static final KEY_MUSIC:Ljava/lang/String; = "music"

.field public static final KEY_NOTIFICATION_PRIORITY:Ljava/lang/String; = "_ALIYUN_NOTIFICATION_PRIORITY_"

.field public static final KEY_NOTIFY_ID:Ljava/lang/String; = "notify_id"

.field public static final KEY_NOTIFY_TYPE:Ljava/lang/String; = "remind"

.field public static final KEY_STYLE:Ljava/lang/String; = "style"

.field public static final KEY_TITLE:Ljava/lang/String; = "title"

.field private static final LOGGER:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

.field public static final NOTIFY_TYPE_SILENT:I = 0x0

.field public static final NOTIFY_TYPE_SOUND:I = 0x2

.field public static final NOTIFY_TYPE_VIBRATE:I = 0x1

.field public static final NOTIFY_TYPE_VIBRATE_SOUND:I = 0x3

.field public static final NO_CUSTOM_NOTIFICATION:I = 0x0

.field private static final TAG:Ljava/lang/String; = "MPS:PushData"


# instance fields
.field private mBigBody:Ljava/lang/String;

.field private mBigPicture:Ljava/lang/String;

.field private mBigTitle:Ljava/lang/String;

.field private mContentText:Ljava/lang/String;

.field private mCustomNotificationId:I

.field private mExtraMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mImage:Ljava/lang/String;

.field private mInboxContent:Ljava/lang/String;

.field private mMsgId:Ljava/lang/String;

.field private mNotificationChannel:Ljava/lang/String;

.field private mNotifyId:I

.field private mNotifyType:I

.field private mPriority:I

.field private mSound:Ljava/lang/String;

.field private mStyle:Ljava/lang/String;

.field private mTitle:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:PushData"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/notification/PushData;->LOGGER:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mPriority:I

    iput v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mCustomNotificationId:I

    return-void
.end method

.method public static parse(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/PushData;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/alibaba/sdk/android/push/notification/PushData;"
        }
    .end annotation

    const-string p0, "_ALIYUN_NOTIFICATION_PRIORITY_"

    const-string v0, "title"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v1, "content"

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_6

    invoke-static {v1}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto/16 :goto_4

    :cond_0
    new-instance v2, Lcom/alibaba/sdk/android/push/notification/PushData;

    invoke-direct {v2}, Lcom/alibaba/sdk/android/push/notification/PushData;-><init>()V

    const-string v4, "remind"

    invoke-interface {p1, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v4, 0x2

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    :cond_1
    const-string v5, "music"

    invoke-interface {p1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const-string v6, "ext"

    invoke-interface {p1, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    const-string v7, "notification_channel"

    invoke-interface {p1, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setTitle(Ljava/lang/String;)V

    invoke-direct {v2, v1}, Lcom/alibaba/sdk/android/push/notification/PushData;->setContentText(Ljava/lang/String;)V

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setNotifyType(I)V

    invoke-direct {v2, v7}, Lcom/alibaba/sdk/android/push/notification/PushData;->setNotificationChannel(Ljava/lang/String;)V

    const-string v0, "image"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setImage(Ljava/lang/String;)V

    const-string v0, "style"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setStyle(Ljava/lang/String;)V

    const-string v0, "big_title"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setBigTitle(Ljava/lang/String;)V

    const-string v0, "big_body"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setBigBody(Ljava/lang/String;)V

    const-string v0, "big_picture"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setBigPicture(Ljava/lang/String;)V

    const-string v0, "inbox_content"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setInboxContent(Ljava/lang/String;)V

    const-string v0, "msg_id"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setMsgId(Ljava/lang/String;)V

    :try_start_0
    const-string v0, "notify_id"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setNotifyId(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    invoke-static {v5}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    :cond_2
    move-object v3, v5

    :goto_0
    invoke-direct {v2, v3}, Lcom/alibaba/sdk/android/push/notification/PushData;->setSound(Ljava/lang/String;)V

    invoke-static {v6}, Lcom/alibaba/sdk/android/ams/common/util/StringUtil;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, v6}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/common/util/JSONUtils;->toMap(Lorg/json/JSONObject;)Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    :goto_1
    invoke-direct {v2, p0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setPriority(Ljava/lang/String;)V

    goto :goto_2

    :cond_3
    const/4 p0, 0x0

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    goto :goto_1

    :goto_2
    invoke-direct {v2, v0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setExtraMap(Ljava/util/Map;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    :catch_0
    move-exception p0

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/PushData;->LOGGER:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "Parse inner json(ext) error:"

    invoke-virtual {v0, v1, p0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_4
    :goto_3
    const-string p0, "custom_notification_id"

    invoke-interface {p1, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {p1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0

    invoke-direct {v2, p0}, Lcom/alibaba/sdk/android/push/notification/PushData;->setCustomNotificationId(I)V

    :cond_5
    return-object v2

    :cond_6
    :goto_4
    sget-object p0, Lcom/alibaba/sdk/android/push/notification/PushData;->LOGGER:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "title or content of notify is empty: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    return-object v3
.end method

.method private setBigBody(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigBody:Ljava/lang/String;

    return-void
.end method

.method private setBigPicture(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigPicture:Ljava/lang/String;

    return-void
.end method

.method private setBigTitle(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigTitle:Ljava/lang/String;

    return-void
.end method

.method private setContentText(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mContentText:Ljava/lang/String;

    return-void
.end method

.method private setCustomNotificationId(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mCustomNotificationId:I

    return-void
.end method

.method private setExtraMap(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mExtraMap:Ljava/util/Map;

    return-void
.end method

.method private setInboxContent(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mInboxContent:Ljava/lang/String;

    return-void
.end method

.method private setMsgId(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mMsgId:Ljava/lang/String;

    return-void
.end method

.method private setNotificationChannel(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotificationChannel:Ljava/lang/String;

    return-void
.end method

.method private setNotifyId(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyId:I

    return-void
.end method

.method private setNotifyType(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyType:I

    return-void
.end method

.method private setPriority(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mPriority:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    sget-object v0, Lcom/alibaba/sdk/android/push/notification/PushData;->LOGGER:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v1, "formar error:\u6570\u5b57\u683c\u5f0f\u9519\u8bef"

    invoke-virtual {v0, v1, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method

.method private setSound(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mSound:Ljava/lang/String;

    return-void
.end method

.method private setStyle(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mStyle:Ljava/lang/String;

    return-void
.end method

.method private setTitle(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mTitle:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getBigBody()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigBody:Ljava/lang/String;

    return-object v0
.end method

.method public getBigPicture()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigPicture:Ljava/lang/String;

    return-object v0
.end method

.method public getBigTitle()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigTitle:Ljava/lang/String;

    return-object v0
.end method

.method public getContentText()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mContentText:Ljava/lang/String;

    return-object v0
.end method

.method public getCustomNotificationId()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mCustomNotificationId:I

    return v0
.end method

.method public getExtraMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mExtraMap:Ljava/util/Map;

    return-object v0
.end method

.method public getImage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mImage:Ljava/lang/String;

    return-object v0
.end method

.method public getInboxContent()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mInboxContent:Ljava/lang/String;

    return-object v0
.end method

.method public getMsgId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mMsgId:Ljava/lang/String;

    return-object v0
.end method

.method public getNotificationChannel()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotificationChannel:Ljava/lang/String;

    return-object v0
.end method

.method public getNotifyId()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyId:I

    return v0
.end method

.method public getNotifyType()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyType:I

    return v0
.end method

.method public getPriority()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mPriority:I

    return v0
.end method

.method public getSound()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mSound:Ljava/lang/String;

    return-object v0
.end method

.method public getStyle()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mStyle:Ljava/lang/String;

    return-object v0
.end method

.method public getTitle()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mTitle:Ljava/lang/String;

    return-object v0
.end method

.method public setImage(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mImage:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PushData{title=\'"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mTitle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', contentText=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mContentText:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', image=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mImage:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', notifyType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyType:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", sound=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mSound:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', notificationChannel=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotificationChannel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', priority="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mPriority:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", customNotificationId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mCustomNotificationId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", extraMap="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mExtraMap:Ljava/util/Map;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", style=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mStyle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', bigTitle=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigTitle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', bigPicture=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigPicture:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', bigBody=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mBigBody:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', inboxContent=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mInboxContent:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', notifyId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mNotifyId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", msgId=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/notification/PushData;->mMsgId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
