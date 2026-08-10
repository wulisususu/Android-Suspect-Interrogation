.class public Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;
.super Ljava/lang/Object;
.source "BizErrorModule.java"


# instance fields
.field public aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

.field public args:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public businessType:Ljava/lang/String;

.field public crossPlatformCrashInfo:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public errorType:I

.field public exceptionArg1:Ljava/lang/String;

.field public exceptionArg2:Ljava/lang/String;

.field public exceptionArg3:Ljava/lang/String;

.field public exceptionArgs:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field public exceptionCode:Ljava/lang/String;

.field public exceptionDetail:Ljava/lang/String;

.field public exceptionId:Ljava/lang/String;

.field public exceptionVersion:Ljava/lang/String;

.field public thread:Ljava/lang/Thread;

.field public throwable:Ljava/lang/Throwable;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    return-void
.end method
