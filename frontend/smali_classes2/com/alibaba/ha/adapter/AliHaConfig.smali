.class public Lcom/alibaba/ha/adapter/AliHaConfig;
.super Ljava/lang/Object;
.source "AliHaConfig.java"


# static fields
.field public static final NO_DEVICE_DATA:I = 0x1

.field public static final NO_NETWORK_DATA:I = 0x4

.field public static final NO_OS_DATA:I = 0x2


# instance fields
.field public appKey:Ljava/lang/String;

.field public appSecret:Ljava/lang/String;

.field public appVersion:Ljava/lang/String;

.field public application:Landroid/app/Application;

.field public channel:Ljava/lang/String;

.field public context:Landroid/content/Context;

.field public enableInterceptNotMainThreadException:Z

.field public initAsync:Z

.field public isAliyunos:Ljava/lang/Boolean;

.field public noCollectionDataType:I

.field public rsaPublicKey:Ljava/lang/String;

.field public tlogFileMaxSize:J

.field public userNick:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->application:Landroid/app/Application;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->context:Landroid/content/Context;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->appKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->appSecret:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->appVersion:Ljava/lang/String;

    const/4 v1, 0x0

    .line 30
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    iput-object v2, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->isAliyunos:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->channel:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->userNick:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->rsaPublicKey:Ljava/lang/String;

    iput-boolean v1, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->initAsync:Z

    iput v1, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->noCollectionDataType:I

    iput-boolean v1, p0, Lcom/alibaba/ha/adapter/AliHaConfig;->enableInterceptNotMainThreadException:Z

    return-void
.end method
