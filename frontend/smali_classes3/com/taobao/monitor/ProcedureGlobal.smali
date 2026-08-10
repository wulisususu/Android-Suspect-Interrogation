.class public Lcom/taobao/monitor/ProcedureGlobal;
.super Ljava/lang/Object;
.source "ProcedureGlobal.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/ProcedureGlobal$Holder;
    }
.end annotation


# static fields
.field public static final PROCEDURE_FACTORY:Lcom/taobao/monitor/procedure/ProcedureFactory;

.field public static final PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;


# instance fields
.field private context:Landroid/content/Context;

.field private final handler:Landroid/os/Handler;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 16
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureManager;-><init>()V

    sput-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    .line 17
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureFactory;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureFactory;-><init>()V

    sput-object v0, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_FACTORY:Lcom/taobao/monitor/procedure/ProcedureFactory;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "APM-Procedure"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 21
    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 22
    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/taobao/monitor/ProcedureGlobal;->handler:Landroid/os/Handler;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/ProcedureGlobal$1;)V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/taobao/monitor/ProcedureGlobal;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/monitor/ProcedureGlobal;
    .locals 1

    .line 26
    sget-object v0, Lcom/taobao/monitor/ProcedureGlobal$Holder;->INSTANCE:Lcom/taobao/monitor/ProcedureGlobal;

    return-object v0
.end method


# virtual methods
.method public context()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/ProcedureGlobal;->context:Landroid/content/Context;

    return-object v0
.end method

.method public handler()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/ProcedureGlobal;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method setContext(Landroid/content/Context;)Lcom/taobao/monitor/ProcedureGlobal;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/ProcedureGlobal;->context:Landroid/content/Context;

    return-object p0
.end method
