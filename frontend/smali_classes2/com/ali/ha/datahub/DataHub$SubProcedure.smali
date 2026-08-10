.class Lcom/ali/ha/datahub/DataHub$SubProcedure;
.super Ljava/lang/Object;
.source "DataHub.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/ha/datahub/DataHub;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SubProcedure"
.end annotation


# instance fields
.field private mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 114
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private constructor <init>(Lcom/ali/ha/datahub/BizSubscriber;)V
    .locals 0

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ali/ha/datahub/DataHub$SubProcedure;->mSubscriber:Lcom/ali/ha/datahub/BizSubscriber;

    return-void
.end method

.method synthetic constructor <init>(Lcom/ali/ha/datahub/BizSubscriber;Lcom/ali/ha/datahub/DataHub$1;)V
    .locals 0

    .line 110
    invoke-direct {p0, p1}, Lcom/ali/ha/datahub/DataHub$SubProcedure;-><init>(Lcom/ali/ha/datahub/BizSubscriber;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/ali/ha/datahub/DataHub$1;)V
    .locals 0

    .line 110
    invoke-direct {p0}, Lcom/ali/ha/datahub/DataHub$SubProcedure;-><init>()V

    return-void
.end method


# virtual methods
.method public onBegin(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onEnd(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onStage(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method
