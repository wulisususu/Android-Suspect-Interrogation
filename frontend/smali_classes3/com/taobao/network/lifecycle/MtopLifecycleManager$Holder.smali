.class final Lcom/taobao/network/lifecycle/MtopLifecycleManager$Holder;
.super Ljava/lang/Object;
.source "MtopLifecycleManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/network/lifecycle/MtopLifecycleManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Holder"
.end annotation


# static fields
.field private static final INSTANCE:Lcom/taobao/network/lifecycle/MtopLifecycleManager;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 104
    new-instance v0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/network/lifecycle/MtopLifecycleManager;-><init>(Lcom/taobao/network/lifecycle/MtopLifecycleManager$1;)V

    sput-object v0, Lcom/taobao/network/lifecycle/MtopLifecycleManager$Holder;->INSTANCE:Lcom/taobao/network/lifecycle/MtopLifecycleManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/taobao/network/lifecycle/MtopLifecycleManager;
    .locals 1

    sget-object v0, Lcom/taobao/network/lifecycle/MtopLifecycleManager$Holder;->INSTANCE:Lcom/taobao/network/lifecycle/MtopLifecycleManager;

    return-object v0
.end method
