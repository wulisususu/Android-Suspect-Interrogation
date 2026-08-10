.class public Lcom/alibaba/ha/protocol/crash/ErrorInfo;
.super Ljava/lang/Object;
.source "ErrorInfo.java"


# static fields
.field public static final HA_BIG_BITMAP:I = 0x7

.field public static final HA_CRASH_ANR:I = 0x3

.field public static final HA_CRASH_JAVA:I = 0x1

.field public static final HA_CRASH_NATIVE:I = 0x2

.field public static final HA_CUSTOM_ERROR:I = 0xa

.field public static final HA_FD_OVERFLOW:I = 0x8

.field public static final HA_FLUTTER_ERROR:I = 0xc

.field public static final HA_MAIN_THREAD_BLOCK:I = 0x5

.field public static final HA_MAIN_THREAD_IO:I = 0x6

.field public static final HA_MEM_LEAK:I = 0x4

.field public static final HA_RESOURCE_LEAK:I = 0x9


# instance fields
.field private mErrorType:I

.field private mThrowable:Ljava/lang/Throwable;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getErrorType()I
    .locals 1

    iget v0, p0, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->mErrorType:I

    return v0
.end method

.method public getThrowable()Ljava/lang/Throwable;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->mThrowable:Ljava/lang/Throwable;

    return-object v0
.end method

.method public setErrorType(I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "errorType"
        }
    .end annotation

    iput p1, p0, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->mErrorType:I

    return-void
.end method

.method public setThrowable(Ljava/lang/Throwable;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "throwable"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/protocol/crash/ErrorInfo;->mThrowable:Ljava/lang/Throwable;

    return-void
.end method
