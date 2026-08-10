.class public Lcom/alibaba/ha/protocol/AliHaParam;
.super Ljava/lang/Object;
.source "AliHaParam.java"


# instance fields
.field public appId:Ljava/lang/String;

.field public appKey:Ljava/lang/String;

.field public appSecret:Ljava/lang/String;

.field public appVersion:Ljava/lang/String;

.field public application:Landroid/app/Application;

.field public channel:Ljava/lang/String;

.field public context:Landroid/content/Context;

.field public enableInterceptNotMainThreadException:Z

.field public initAsync:Z

.field public noCollectionDataType:I

.field public tlogFileMaxSize:J

.field public userNick:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->initAsync:Z

    iput v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->noCollectionDataType:I

    iput-boolean v0, p0, Lcom/alibaba/ha/protocol/AliHaParam;->enableInterceptNotMainThreadException:Z

    return-void
.end method
