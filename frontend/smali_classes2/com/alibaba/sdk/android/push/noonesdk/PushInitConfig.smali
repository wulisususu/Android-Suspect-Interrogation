.class public Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    }
.end annotation


# instance fields
.field private final mAccsAppConnectHost:Ljava/lang/String;

.field private final mAccsSilentConnectHost:Ljava/lang/String;

.field private final mAppKey:Ljava/lang/String;

.field private final mAppSecret:Ljava/lang/String;

.field private final mApplication:Landroid/app/Application;

.field private final mDisableChannelProcess:Z

.field private final mDisableChannelProcessHeartbeat:Z

.field private final mDisableForegroundCheck:Z

.field private final mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

.field private final mLoopInterval:J

.field private final mLoopStartChannel:Z

.field private final mPushHost:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$000(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Landroid/app/Application;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mApplication:Landroid/app/Application;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$100(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAppKey:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$200(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAppSecret:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$300(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableChannelProcess:Z

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$400(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLoopStartChannel:Z

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$500(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLoopInterval:J

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$600(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableForegroundCheck:Z

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$700(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableChannelProcessHeartbeat:Z

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$800(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mPushHost:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$900(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAccsAppConnectHost:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$1000(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAccsSilentConnectHost:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->access$1100(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    move-result-object p1

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    return-void
.end method


# virtual methods
.method public getAccsAppConnectHost()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAccsAppConnectHost:Ljava/lang/String;

    return-object v0
.end method

.method public getAccsSilentConnectHost()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAccsSilentConnectHost:Ljava/lang/String;

    return-object v0
.end method

.method public getAppKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAppKey:Ljava/lang/String;

    return-object v0
.end method

.method public getAppSecret()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mAppSecret:Ljava/lang/String;

    return-object v0
.end method

.method public getApplication()Landroid/app/Application;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mApplication:Landroid/app/Application;

    return-object v0
.end method

.method public getLargeIconDownloadListener()Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    return-object v0
.end method

.method public getLoopInterval()J
    .locals 2

    iget-wide v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLoopInterval:J

    return-wide v0
.end method

.method public getPushHost()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mPushHost:Ljava/lang/String;

    return-object v0
.end method

.method public isDisableChannelProcess()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableChannelProcess:Z

    return v0
.end method

.method public isDisableChannelProcessHeartbeat()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableChannelProcessHeartbeat:Z

    return v0
.end method

.method public isDisableForegroundCheck()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mDisableForegroundCheck:Z

    return v0
.end method

.method public isLoopStartChannel()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;->mLoopStartChannel:Z

    return v0
.end method
