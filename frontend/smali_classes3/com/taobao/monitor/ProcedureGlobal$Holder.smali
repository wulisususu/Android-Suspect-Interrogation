.class Lcom/taobao/monitor/ProcedureGlobal$Holder;
.super Ljava/lang/Object;
.source "ProcedureGlobal.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/ProcedureGlobal;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Holder"
.end annotation


# static fields
.field static final INSTANCE:Lcom/taobao/monitor/ProcedureGlobal;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 43
    new-instance v0, Lcom/taobao/monitor/ProcedureGlobal;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/monitor/ProcedureGlobal;-><init>(Lcom/taobao/monitor/ProcedureGlobal$1;)V

    sput-object v0, Lcom/taobao/monitor/ProcedureGlobal$Holder;->INSTANCE:Lcom/taobao/monitor/ProcedureGlobal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
