.class Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager$a;
.super Ljava/lang/Object;
.source "EnhancedActivityLifeCycleManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager$a;->a:Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;

    return-void
.end method

.method static synthetic a()Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager$a;->a:Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;

    return-object v0
.end method
