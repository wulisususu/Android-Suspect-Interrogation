.class Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$Holder;
.super Ljava/lang/Object;
.source "PhenixLifeCycleManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Holder"
.end annotation


# static fields
.field private static final INSTANCE:Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 111
    new-instance v0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;-><init>(Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$1;)V

    sput-object v0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$Holder;->INSTANCE:Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 110
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;
    .locals 1

    sget-object v0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$Holder;->INSTANCE:Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;

    return-object v0
.end method
