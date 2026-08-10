.class final Lorg/android/spdy/ProtectedPointerTest$1;
.super Ljava/lang/Object;
.source "ProtectedPointerTest.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/android/spdy/ProtectedPointerTest;->test_close_with_work(Lorg/android/spdy/ProtectedPointer;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$pptr:Lorg/android/spdy/ProtectedPointer;


# direct methods
.method constructor <init>(Lorg/android/spdy/ProtectedPointer;)V
    .locals 0

    iput-object p1, p0, Lorg/android/spdy/ProtectedPointerTest$1;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0x3e8

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Lorg/android/spdy/ProtectedPointerTest$1;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 40
    invoke-virtual {v1}, Lorg/android/spdy/ProtectedPointer;->enter()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lorg/android/spdy/ProtectedPointerTest$1;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 41
    invoke-virtual {v1}, Lorg/android/spdy/ProtectedPointer;->getData()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/android/spdy/ProtectedPointerTest$Data;

    .line 42
    invoke-virtual {v1}, Lorg/android/spdy/ProtectedPointerTest$Data;->work()V

    iget-object v1, p0, Lorg/android/spdy/ProtectedPointerTest$1;->val$pptr:Lorg/android/spdy/ProtectedPointer;

    .line 43
    invoke-virtual {v1}, Lorg/android/spdy/ProtectedPointer;->exit()V

    goto :goto_1

    .line 45
    :cond_0
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "the data has been destroy"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method
