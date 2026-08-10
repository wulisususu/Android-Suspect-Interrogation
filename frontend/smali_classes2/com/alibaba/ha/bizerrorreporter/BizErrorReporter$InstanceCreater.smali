.class Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$InstanceCreater;
.super Ljava/lang/Object;
.source "BizErrorReporter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "InstanceCreater"
.end annotation


# static fields
.field private static instance:Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 51
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;-><init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$1;)V

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$InstanceCreater;->instance:Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$InstanceCreater;->instance:Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    return-object v0
.end method
